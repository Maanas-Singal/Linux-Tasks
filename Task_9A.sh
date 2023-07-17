#!/bin/bash

# Twilio credentials
ACCOUNT_SID="your_account_sid"
AUTH_TOKEN="your_auth_token"
TWILIO_PHONE_NUMBER="your_twilio_phone_number"
TO_PHONE_NUMBER="recipient_phone_number"

# Message content
MESSAGE="Hello from Twilio!"

# Send WhatsApp message using Twilio API
curl -X POST "https://api.twilio.com/2010-04-01/Accounts/$ACCOUNT_SID/Messages.json" \
    --data-urlencode "From=whatsapp:$TWILIO_PHONE_NUMBER" \
    --data-urlencode "To=whatsapp:$TO_PHONE_NUMBER" \
    --data-urlencode "Body=$MESSAGE" \
    -u "$ACCOUNT_SID:$AUTH_TOKEN"

## For the above script to work, you'll need to sign up for a Twilio account and obtain your Account SID, Auth Token, and a Twilio phone number.
