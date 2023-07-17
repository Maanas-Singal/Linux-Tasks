#!/bin/bash

# Check if the SSH command exists
if ! command -v ssh &>/dev/null; then
  echo "SSH is not installed. Please install it using your package manager."
  exit 1
fi

# Replace 'USERNAME' with your Windows username and 'WINDOWS_IP' with the IP address of your Windows machine
WINDOWS_USER="USERNAME"
WINDOWS_IP="WINDOWS_IP"

# Make sure to replace 'USERNAME' and 'WINDOWS_IP' with appropriate values for your Windows system

# The command to launch the browser on Windows (adjust as needed for your browser)
BROWSER_COMMAND="start firefox"

# SSH command to forward X11 and execute the browser command on the Windows machine
ssh -Y "$WINDOWS_USER"@"$WINDOWS_IP" "$BROWSER_COMMAND"

# Save the script as "launch_browser.sh" and run it on the linux sysytem
# ./launch_browser.sh
