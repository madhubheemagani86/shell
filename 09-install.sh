#!bin/bash

# Check if the script is run as root
if [ $EUID -ne 0 ]; then
    echo "Error: This script must be run as root."
    exit 1
fi

# Accept a package name as an argument
package=$1

# Check if the package is already installed
if rpm -q $package &> /dev/null; then
    echo "$package is already installed."
    exit 0
fi

# Install the package using dnf
dnf install -y $package

# Check the exit status of the installation
if [ $? -eq 0 ]; then
    echo "$package installed successfully."
else
    echo "Failed to install $package."
    exit 1
fi