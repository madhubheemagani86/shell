#!bin/bash

print_header() {
    echo "------------------------------"
    echo "$1"
    echo "------------------------------"
}   
print_header "Package Installation Status"
dnf install -y git wget curl > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "SUCCESS: git, wget, and curl installed successfully."
else
    echo "FAILURE: Failed to install git, wget, and/or curl."
fi  
