#!/bin/bash

# Check if the script is being run with root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script requires root privileges. Please run it with sudo."
  exit 1
fi

# Function to check if a package is installed
package_installed() {
  dpkg -l "$1" &> /dev/null
}

# Function to install packages on Debian/Ubuntu-based systems
install_debian_packages() {
  for package in "$@"; do
    if ! package_installed "$package"; then
      apt-get install -y "$package"
    else
      echo "$package is already installed."
    fi
  done
}

# Function to install packages on Red Hat/CentOS-based systems
install_rhel_packages() {
  for package in "$@"; do
    if ! package_installed "$package"; then
      yum install -y "$package"
    else
      echo "$package is already installed."
    fi
  done
}

# Function to install packages on Arch Linux
install_arch_packages() {
  for package in "$@"; do
    if ! package_installed "$package"; then
      pacman -S --noconfirm "$package"
    else
      echo "$package is already installed."
    fi
  done
}

# Determine the Linux distribution
distro=""
if [ -f "/etc/os-release" ]; then
  distro=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')
fi

# Install GPM and other required dependencies based on the Linux distribution
case "$distro" in
  debian|ubuntu)
    echo "Detected Debian/Ubuntu-based system."
    install_debian_packages gpm
    ;;
  centos|rhel)
    echo "Detected Red Hat/CentOS-based system."
    install_rhel_packages gpm
    ;;
  arch)
    echo "Detected Arch Linux system."
    install_arch_packages gpm
    ;;
  *)
    echo "Unsupported or unrecognized Linux distribution."
    echo "Please install GPM manually."
    exit 1
    ;;
esac

echo "Dependencies installation completed successfully!"

# To use the mouse in a black screen Linux CLI, 
# you need to install the required dependencies, 
# such as the GPM (General Purpose Mouse) package
