#!bin/bash

print_header() {
    echo "------------------------------"
    echo "$1"
    echo "------------------------------"
}   
print_header "Package Installation Status"
dnf install -y $1 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "SUCCESS: $1 installed successfully."
else
    echo "FAILURE: Failed to install $1."
fi  
