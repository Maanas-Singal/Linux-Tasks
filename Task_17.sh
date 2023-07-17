#!/bin/bash

# Function to display progress bar
function show_progress() {
    local progress=$1
    local bar_length=40
    local completed_length=$((progress * bar_length / 100))
    local remaining_length=$((bar_length - completed_length))

    printf "\rProgress: [%${completed_length}s%${remaining_length}s] %d%%" \
        "$bar_fill" "$bar_empty" "$progress"
}

# Command to execute
YOUR_COMMAND="sleep 5"

# Start time
start_time=$(date +%s)

# Execute command in the background
$YOUR_COMMAND &

# Get the process ID of the command
pid=$!

# Wait for the command to complete and update progress
while kill -0 "$pid" 2>/dev/null; do
    # Calculate elapsed time
    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))

    # Calculate progress as a percentage
    progress=$((elapsed_time * 100 / 5))  # Change '5' to the desired duration of your command

    show_progress "$progress"

    # Delay to reduce CPU usage
    sleep 0.1
done

# Clear the progress bar
printf "\r%-${bar_length}s\n" " "

# Print the total elapsed time
printf "Command completed in %d seconds.\n" "$elapsed_time"

## Note: The script assumes that the command will take a fixed duration (in this case, 5 seconds). 
## You may need to adjust the calculation of the progress variable based on the expected duration of your specific command.
