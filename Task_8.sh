#!/bin/bash

# Email settings
TO_EMAIL="recipient@example.com"
FROM_EMAIL="sender@example.com"
SUBJECT="Test Email"
BODY="Hello from the command line!"

# Send email using sendmail
echo -e "Subject:$SUBJECT\n\n$BODY" | sendmail -f "$FROM_EMAIL" "$TO_EMAIL"

## Remember to replace the placeholder values with your actual credentials, phone numbers, and email addresses. 
## Additionally, be aware that the above scripts use external services and may incur costs or have usage limitations depending on the service provider.
