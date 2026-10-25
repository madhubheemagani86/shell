#!/bin/bash

OVERALL_STATUS=0

# 1. Check ls /tmp
ls /tmp > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "SUCCESS"
else
    echo "FAILURE"
    OVERALL_STATUS=1
fi

# 2. Check ls /fakedir
ls /fakedir > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "SUCCESS"
else
    echo "FAILURE"
    OVERALL_STATUS=1
fi

# 3. Check connectivity to google.com
ping -c1 google.com > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "Host reachable"
else
    echo "Host not reachable"
    OVERALL_STATUS=1
fi

# 4. Exit with appropriate code
exit $OVERALL_STATUS