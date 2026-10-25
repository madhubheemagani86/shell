#!bin/bash

#Store your name, age, and city in variables
name="John"
age=25
city="New York"

#Print a sentence using all three variables
echo "My name is $name, I am $age years old, and I live in $city."

#Calculate and print how many years until you turn 60
years_left=$((60 - age))
echo "I have $years_left years left until I turn 60."

#Change the name variable to a different name and verify only one line needs to change
name="Jane"
echo "My name is now $name."
echo "Years until 60: $years_left"
