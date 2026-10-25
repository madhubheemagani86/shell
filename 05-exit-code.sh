!#bin/bash

ls /tmp
if [ $? -eq 0 ]; then
    echo "SUCCESS"
else
    echo "FAILURE"
fi

ls /fakedir
if[$? -eq 0]; then
    echo "SUCCESS"
else
    echo "FAILURE"
fi

ping -c1 google.com
if [ $? -eq 0 ]; then
    echo "Host reachable"
else
    echo "Host not reachable"
fi

# Exit with code 0 if all commands succeeded, or 1 if any failed
exit_code=0
ls /tmp
if [ $? -ne 0 ]; then
    exit_code=1
fi

ls /fakedir
if [ $? -ne 0 ]; then
    exit_code=1
fi

ping -c1 google.com
if [ $? -ne 0 ]; then
    exit_code=1
fi

exit $exit_code