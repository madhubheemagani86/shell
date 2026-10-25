#!bin/bash

# Get today's day
day=$(date +%u)

# Check the day and print appropriate message
if [ $day -eq 6 ] || [ $day -eq 7 ]; then
    echo "Weekend! Enjoy your holiday."
elif [ $day -eq 1 ]; then
    echo "Start of the week. Let's go!"
else
    echo "Weekday. Go to school/work."
fi