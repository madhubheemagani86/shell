#!/bin/bash

# Function to print a header
print_header() {
    echo "========================================"
    echo "$1"
    echo "========================================"
}

# Function to check command status
check_status() {
    local exit_code=$1
    local message="$2"

    if [ "$exit_code" -eq 0 ]; then
        echo "SUCCESS: $message"
    else
        echo "FAILURE: $message"
    fi
}

# Function to install a package
install_package() {
    local package=$1

    print_header "Checking package: $package"

    if rpm -q "$package" &>/dev/null; then
        echo "$package is already installed."
        check_status 0 "$package already installed"
    else
        sudo dnf install -y "$package"
        check_status $? "Installing $package"
    fi
}

# Install required packages
install_package git
install_package wget
install_package curl
