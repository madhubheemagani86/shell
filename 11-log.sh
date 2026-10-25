#!bin/bash

# Creates a log file at /tmp/script.log
# Redirects all success output to the log file
# Redirects all error output to /tmp/script-errors.log
# Runs three commands: ls /tmp, ls /fakedir, date
# At the end, prints the contents of both log files

exec > /tmp/script.log 2> /tmp/script-errors.log

ls /tmp
ls /fakedir
date

echo "Contents of script.log:"
cat /tmp/script.log
echo "Contents of script-errors.log:"
cat /tmp/script-errors.log