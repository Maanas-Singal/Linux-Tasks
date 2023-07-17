#!/bin/bash

# Network Interface and IP Address Configuration
# System 1
sys1_interface="eth0"
sys1_ip="192.168.0.1"
sys1_subnet="192.168.0.0/24"

# System 2
sys2_interface="eth0"
sys2_ip="192.168.0.2"
sys2_subnet="192.168.0.0/24"

# System 3
sys3_interface="eth0"
sys3_ip="192.168.0.3"
sys3_subnet="192.168.0.0/24"

# System 4
sys4_interface="eth0"
sys4_ip="192.168.0.4"
sys4_subnet="192.168.0.0/24"

# System 5
sys5_interface="eth0"
sys5_ip="192.168.0.5"
sys5_subnet="192.168.0.0/24"

# Enable IP Forwarding on all systems
for sys in sys1 sys2 sys3 sys4 sys5; do
  echo "Enabling IP Forwarding on ${!sys}..."
  sudo sysctl net.ipv4.ip_forward=1
done

# Configure IP addresses on each system
for sys in sys1 sys2 sys3 sys4 sys5; do
  echo "Configuring IP address on ${!sys}..."
  sudo ip addr add ${!sys}_ip/24 dev ${!sys}_interface
  sudo ip link set ${!sys}_interface up
done

# Add static routes for other systems on each system
for sys in sys1 sys2 sys3 sys4 sys5; do
  for dest_sys in sys1 sys2 sys3 sys4 sys5; do
    if [ "$sys" != "$dest_sys" ]; then
      echo "Adding route to ${dest_sys} via ${!dest_sys}_ip on ${!sys}..."
      sudo ip route add ${!dest_sys}_subnet via ${!dest_sys}_ip
    fi
  done
done

# Additional network configurations (you can add more as needed)
# For example, setting up a DHCP server on one of the systems

# System 1 (DHCP server)
sudo apt-get update
sudo apt-get install isc-dhcp-server -y

# Backup the original configuration file
sudo cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.bak

# Configure DHCP server
sudo cat <<EOL > /etc/dhcp/dhcpd.conf
subnet 192.168.0.0 netmask 255.255.255.0 {
  range 192.168.0.100 192.168.0.200;
  option routers 192.168.0.1;
  option domain-name-servers 8.8.8.8;
  option domain-name "example.com";
}
EOL

# Start the DHCP server
sudo systemctl start isc-dhcp-server

echo "Network setup complete!"

# This script sets up a simple network with five systems. 
# Each system is assigned a static IP address, and IP forwarding is enabled on each system to allow for routing between them. 
# Additionally, the script installs and configures a DHCP server on System 1 to provide dynamic IP addresses to other systems within the specified range.
