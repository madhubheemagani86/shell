#!/bin/bash

ami_id="ami-0055977a6e828a4f4"
instance_type="t3.micro"
domain_name="lmsconsultant.shop"
hosted_zone_id="Z02446633PE609T8XV8U4"

for instance in "$@"
do
    echo "Creating instance: $instance"

    instance_id=$(aws ec2 run-instances \
        --image-id "$ami_id" \
        --instance-type "$instance_type" \
        --security-groups "moodle-sg" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=moodle-$instance}]" \
        --user-data "$(cat <<'EOF'
#!/bin/bash

dnf update -y

# Apache
dnf install -y httpd git wget unzip

systemctl enable httpd
systemctl start httpd

# PHP 8.2
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm

dnf module reset php -y
dnf module enable php:remi-8.2 -y

dnf install -y \
php \
php-cli \
php-common \
php-fpm \
php-opcache \
php-gd \
php-curl \
php-mysqlnd \
php-intl \
php-zip \
php-soap \
php-xml \
php-mbstring \
php-sodium \
php-bcmath

# MySQL 8.4
dnf install -y \
https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm

dnf install -y mysql-community-server

systemctl enable mysqld
systemctl start mysqld

# Moodle directories
mkdir -p /var/www/public_html
mkdir -p /var/moodledata

# Moodle source
git clone -b MOODLE_503_STABLE \
https://github.com/moodle/moodle.git \
/var/www/public_html/moodle

# Permissions
chown -R apache:apache /var/www/public_html/moodle
chown -R apache:apache /var/moodledata

chmod -R 755 /var/www/public_html/moodle
chmod -R 770 /var/moodledata

# PHP settings
sed -i 's/^memory_limit.*/memory_limit = 512M/' /etc/php.ini
sed -i 's/^upload_max_filesize.*/upload_max_filesize = 512M/' /etc/php.ini
sed -i 's/^post_max_size.*/post_max_size = 512M/' /etc/php.ini
sed -i 's/^max_execution_time.*/max_execution_time = 300/' /etc/php.ini

# VirtualHost
cat > /etc/httpd/conf.d/moodle.conf <<EOL
<VirtualHost *:80>
    ServerName lmsconsultant.shop
    ServerAlias www.lmsconsultant.shop

    DocumentRoot /var/www/public_html/moodle

    <Directory /var/www/public_html/moodle>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /var/log/httpd/moodle-error.log
    CustomLog /var/log/httpd/moodle-access.log combined
</VirtualHost>
EOL

# SELinux
setsebool -P httpd_can_network_connect 1
setsebool -P httpd_can_network_connect_db 1
chcon -R -t httpd_sys_rw_content_t /var/moodledata

# Firewall
firewall-cmd --permanent --add-service=http || true
firewall-cmd --permanent --add-service=https || true
firewall-cmd --reload || true

systemctl restart httpd

echo "Moodle installation completed" > /root/moodle-install.log
EOF
)" \
        --query 'Instances[0].InstanceId' \
        --output text)

    echo "Instance ID: $instance_id"

    echo "Waiting for instance to start..."
    aws ec2 wait instance-running --instance-ids "$instance_id"

    if [ "$instance" = "moodle" ]; then

        IP=$(aws ec2 describe-instances \
            --instance-ids "$instance_id" \
            --query 'Reservations[0].Instances[0].PublicIpAddress' \
            --output text)

        r53_record="$domain_name"

        echo "Waiting for public IP..."
        while [ "$IP" = "None" ] || [ -z "$IP" ]; do
            sleep 10
            IP=$(aws ec2 describe-instances \
                --instance-ids "$instance_id" \
                --query 'Reservations[0].Instances[0].PublicIpAddress' \
                --output text)
        done

    else

        IP=$(aws ec2 describe-instances \
            --instance-ids "$instance_id" \
            --query 'Reservations[0].Instances[0].PrivateIpAddress' \
            --output text)

        r53_record="${instance}.${domain_name}"

    fi

    echo "Creating Route53 record: $r53_record -> $IP"

    aws route53 change-resource-record-sets \
        --hosted-zone-id "$hosted_zone_id" \
        --change-batch "{
            \"Changes\": [
                {
                    \"Action\": \"UPSERT\",
                    \"ResourceRecordSet\": {
                        \"Name\": \"${r53_record}\",
                        \"Type\": \"A\",
                        \"TTL\": 300,
                        \"ResourceRecords\": [
                            {
                                \"Value\": \"${IP}\"
                            }
                        ]
                    }
                }
            ]
        }"

    echo "Updated Route53 record for $instance"
done