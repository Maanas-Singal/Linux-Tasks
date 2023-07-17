#!/bin/bash

# Install "xprintidle" using your package manager 
# In this example, we are using Ubuntu Linux OS
sudo apt-get update
sudo apt-get install xprintidle

# Define the inactivity timeout in milliseconds (adjust as needed)
timeout_ms=600000 # 10 minutes (1 minute = 60000 milliseconds)

# Function to close the terminal gracefully
function close_terminal() {
  # Try to close the terminal using the exit command
  # You can adjust this to your specific terminal emulator (e.g., gnome-terminal, xterm)
  # Replace 'gnome-terminal' with your terminal emulator's command.
  gnome-terminal -- bash -c "sleep 2; exit"
}

# Main loop
while true; do
  # Get the idle time in milliseconds
  idle_time=$(xprintidle)

  # Check if the terminal has been inactive for longer than the timeout
  if [ "$idle_time" -ge "$timeout_ms" ]; then
    echo "Terminal has been inactive for too long. Closing..."
    close_terminal
    break
  fi

  # Sleep for a short interval before checking again
  sleep 10 # Check every 10 seconds (adjust as needed)
done
