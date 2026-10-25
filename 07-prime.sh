#!bin/bash

# Check for factors
for ((i=2; i*i<=$1; i++))
do
    if (( $1 % i == 0 )); then
        echo "$1 is not a Prime Number"
        exit 0
    fi
done

echo "$1 is a Prime Number"