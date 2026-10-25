#!/bin/bash

# 1. Prints Hello, World!
echo "Hello, World!"

# 2. Prints the current date and time
echo "Current Date & Time: $(date)"

# 3. Prints the name of the user running the script
echo "Current User: $USER"

# 4. Prints the directory the script is running from
echo "Script Directory: $(dirname "$(readlink -f "$0")")"
