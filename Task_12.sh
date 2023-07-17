#!/bin/bash

# Check if Xvfb is installed
if ! command -v Xvfb &>/dev/null; then
  echo "Xvfb is not installed. Please install it using your package manager."
  exit 1
fi

# Check if xdotool is installed
if ! command -v xdotool &>/dev/null; then
  echo "xdotool is not installed. Please install it using your package manager."
  exit 1
fi

# Set the display number for Xvfb
DISPLAY_NUM=99

# Start Xvfb
Xvfb :$DISPLAY_NUM -screen 0 1024x768x16 &
XVFB_PID=$!

# Set the display variable for the launched applications
export DISPLAY=:$DISPLAY_NUM

# Launch Notepad (Gedit) in the background
gedit &

# Wait for Notepad (Gedit) to open
sleep 2

# Use xdotool to simulate pressing the 'Alt' and 'F4' keys to close Notepad (Gedit)
xdotool key --window "$(xdotool search --name "Untitled Document")" alt+F4

# Launch Firefox in the background
firefox &

# Wait for Firefox to open
sleep 5

# Use xdotool to simulate entering a website and pressing 'Enter'
xdotool type "https://www.example.com"
xdotool key KP_Enter

# Keep the script running to maintain the virtual display until the user interrupts it
read -rp "Press Enter to exit..."
kill $XVFB_PID
