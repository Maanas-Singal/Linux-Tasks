#!/bin/bash

# Check if the script is being run with root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script requires root privileges. Please run it with sudo."
  exit 1
fi

# Install Terminator (CLI terminal emulator)
echo "Installing Terminator..."
apt-get update
apt-get install terminator -y

# Install GNOME Terminal (GUI terminal emulator)
echo "Installing GNOME Terminal..."
apt-get install gnome-terminal -y

echo "Terminal installation completed successfully!"

## Please note that this script assumes you are using a Debian-based Linux distribution like Ubuntu. 
## If you are using a different Linux distribution, you might need to modify the package manager commands accordingly.
## Creating a bash script to add more CLI and GUI terminals in Linux would involve installing new terminal emulators.
## Save and run this script using "root" or "sudo" privileges.
