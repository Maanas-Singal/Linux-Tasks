#!/bin/bash

# Check the number of arguments
if [ $# -ne 1 ]; then
  echo "Usage: $0 <username>"
  exit 1
fi

username="$1"
fifo_file="/tmp/chat_fifo"

# Create a named pipe if it doesn't exist
if [ ! -p "$fifo_file" ]; then
  mkfifo "$fifo_file"
fi

# Function to send a message
function send_message() {
  local message="$1"
  echo "$username: $message" > "$fifo_file"
}

# Function to receive messages
function receive_messages() {
  tail -f "$fifo_file" | grep -v "^$username:"
}

# Print instructions
echo "Welcome to the chat program! Type 'exit' to quit."

# Start receiving messages in the background
receive_messages &

# Main loop
while true; do
  read -r message
  if [ "$message" == "exit" ]; then
    echo "Exiting chat program."
    send_message "$username has left the chat."
    break
  fi
  send_message "$message"
done

# Clean up and remove the named pipe
rm -f "$fifo_file"

# To use the chat program, open two terminals and run the script with different usernames on each terminal:
# Terminal 1 -----"./chat_program.sh user1"
# Terminal 2 -----"./chat_program.sh user2"


