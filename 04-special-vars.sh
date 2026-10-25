#!bin/bash

# Capture start time
START_TIME=$SECONDS

# Print who is running the script
echo "User: $USER"

# Print the current directory
echo "Current directory: $PWD"

# Print the home directory
echo "Home directory: $HOME"

# Print the PID of the script
echo "Script PID: $$"

# Run sleep 10 in the background and print its PID
sleep 10 &
echo "Background process PID: $!"

# Print a random number between 1–100
echo "Random number: $((RANDOM % 100 + 1))"

# Print execution time
echo "Script took $START_TIME seconds to run"