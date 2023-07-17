#!/bin/bash

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please try again with sudo."
    exit 1
fi

# Define the maximum number of failed attempts before locking the account
MAX_FAILED_ATTEMPTS=3

# Backup the original PAM configuration file
cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bak

# Create a new PAM configuration
cat <<EOL > /etc/pam.d/common-auth
# /etc/pam.d/common-auth - authentication settings common to all services

# Ensure sufficient pam_unix.so module for normal password authentication
auth    [success=1 default=ignore]  pam_unix.so nullok_secure

# Uncomment the following line to implicitly trust users in the "sudo" group.
# auth    [success=ignore default=1] pam_unix.so nullok_secure auth_trust_sudo.so

# Uncomment the following line to require a strong password:
# auth    required    pam_pwquality.so retry=3

# Lock account after MAX_FAILED_ATTEMPTS
auth    required    pam_tally2.so deny=${MAX_FAILED_ATTEMPTS} onerr=fail unlock_time=300

# Additional module to include with this service
auth    optional    pam_cap.so
EOL

echo "Account lock after ${MAX_FAILED_ATTEMPTS} failed login attempts is now set."

# Make sure the PAM configuration has the correct permissions
chmod 644 /etc/pam.d/common-auth

# Print a message explaining how to revert the changes if needed
echo "To revert the changes and restore the original PAM configuration, run:"
echo "sudo cp /etc/pam.d/common-auth.bak /etc/pam.d/common-auth"

# To apply the changes, save and run the script with root privileges: "sudo ./set_account_lock.sh"
