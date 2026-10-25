!#bin/bash

if [ $(( $1 % 2 )) -eq 0 ]; then
    echo "$1 is even"
else
 if [ $(( $1 % 2 )) -eq 1 ]; then
    echo "$1 is a prime number"
    else
    echo "$1 is not a prime number but odd"
fi