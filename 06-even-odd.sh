!#bin/bash 

if [ $1 % 2 -eq 0 ]; then
    echo "$1 is an even number"
else
    echo "$1 is an odd number"
fi