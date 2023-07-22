#!/bin/bash

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Install required dependencies
dnf install -y dnf-plugins-core

# Enable the CodeReady Linux Builder repository for RHEL 8 (required for Wine)
if [ -f /etc/redhat-release ] && grep -qi "release 8" /etc/redhat-release; then
  dnf config-manager --set-enabled codeready-builder-for-rhel-8
fi

# Install Wine and Winetricks
dnf install -y wine winetricks

# Run Wine configuration for the current user
sudo -u $(logname) winecfg

# Optionally, you can install PlayOnLinux for a user-friendly Wine frontend
read -p "Do you want to install PlayOnLinux? (y/n): " install_pol
if [ "$install_pol" == "y" ]; then
  dnf install -y playonlinux
fi

echo "Wine installation and configuration completed successfully!"

### Before running the script, make sure to give execute permissions to the script:
### chmod +x Install_Wine_RHEL.sh
