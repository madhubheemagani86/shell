#!/bin/bash

# Validate argument
if [ $# -eq 0 ]; then
    echo "ERROR: Server name is required."
    echo "Usage: $0 <server-name>"
    exit 1
fi

SERVER_NAME=$1

# Function to print section headings
section() {
    echo
    echo "========================================"
    echo "$1"
    echo "========================================"
}

# Script information
section "SCRIPT INFORMATION"
echo "Start Time : $(date)"
echo "PID        : $$"

# Server information
section "SERVER INFORMATION"
echo "Server Label : $SERVER_NAME"

# User information
section "USER INFORMATION"
echo "Current User   : $USER"
echo "Home Directory : $HOME"

# OS information
section "OS INFORMATION"
cat /etc/os-release | grep PRETTY

# Disk usage
section "DISK USAGE"
df -h /

# Memory usage
section "MEMORY USAGE"
free -h

# Uptime
section "SYSTEM UPTIME"
uptime