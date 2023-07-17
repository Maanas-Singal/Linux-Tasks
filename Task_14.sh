#!/bin/bash

# List of remote server addresses
servers=("server1_ip" "server2_ip" "server3_ip" "server4_ip" "server5_ip")

# List of remote server SSH ports (default is 22, change if needed)
ssh_ports=("22" "22" "22" "22" "22")

# List of local ports for tunneling (can be any available port)
local_ports=("5001" "5002" "5003" "5004" "5005")

# SSH user for connecting to the remote servers (change 'username' to your SSH username)
ssh_user="username"

# Function to create SSH tunnels
create_tunnel() {
    local server=$1
    local ssh_port=$2
    local local_port=$3

    ssh -N -f -L ${local_port}:localhost:22 ${ssh_user}@${server} -p ${ssh_port}
    if [ $? -eq 0 ]; then
        echo "Tunnel created for ${server} on local port ${local_port}."
    else
        echo "Failed to create tunnel for ${server}."
    fi
}

# Main script
main() {
    if [ ${#servers[@]} -ne ${#local_ports[@]} ] || [ ${#ssh_ports[@]} -ne ${#local_ports[@]} ]; then
        echo "The number of servers, SSH ports, and local ports must be the same."
        exit 1
    fi

    for i in "${!servers[@]}"; do
        create_tunnel "${servers[i]}" "${ssh_ports[i]}" "${local_ports[i]}"
    done

    echo "All SSH tunnels created successfully."

    # Keep the script running (remove this if you want it to exit immediately)
    while true; do
        sleep 1
    done
}

# Run the main function
main

## Replace "server1_ip", "server2_ip", etc., with the actual IP addresses of your remote servers. 
## Make sure you have SSH access to these servers using the specified SSH user. 
## Also, update "username" with your actual SSH username.
## Please note that running this script will keep it running indefinitely since I added a loop at the end to keep it active.
