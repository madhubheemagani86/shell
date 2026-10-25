!#bin/bash

if [ $(( $1 % 2 )) -eq 0 ]; then
    echo "$1 is even"
else
    echo "$1 is odd"
fi

if [$1 %2 -eq 0 and $1 -gt 1 ]; then
echo "$1 is prime number"
else
echo "$1 is not a prime number"
fi