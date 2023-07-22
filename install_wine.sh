#!/bin/bash

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Update package lists
apt update

# Install Wine and Winetricks
apt install -y wine winetricks

# Run Wine configuration for the current user
sudo -u $(logname) winecfg

# Optionally, you can install PlayOnLinux for a user-friendly Wine frontend
read -p "Do you want to install PlayOnLinux? (y/n): " install_pol
if [ "$install_pol" == "y" ]; then
  apt install -y playonlinux
fi

echo "Wine installation and configuration completed successfully!"

### Before running the script, make sure to give execute permissions to the script:
### chmod +x install_wine.sh
### Run the script as root:
### sudo ./install_wine.sh
