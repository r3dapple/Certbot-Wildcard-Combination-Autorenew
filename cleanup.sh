#!/bin/bash

# source from https://certbot.eff.org/docs/using.html?highlight=renew#pre-and-post-validation-hooks

if [ -n "$CERTBOT_TOKEN" ]
then
# I think CERTBOT_TOKEN has to be used so certbot knows this script is also a cleanup for the http-01 challenge; it probably does a textsearch before running it
rm -f /var/www/r3dapple/.well-known/acme-challenge/${CERTBOT_TOKEN}
rm -r /var/www/r3dapple/.well-known
exit 0
fi

# Get your API key from https://www.cloudflare.com/a/account/my-account
API_KEY="your_apikey"
EMAIL="your_email"

if [ -f /tmp/CERTBOT_$CERTBOT_DOMAIN/ZONE_ID ]; then
        ZONE_ID=$(cat /tmp/CERTBOT_$CERTBOT_DOMAIN/ZONE_ID)
        rm -f /tmp/CERTBOT_$CERTBOT_DOMAIN/ZONE_ID
fi

if [ -f /tmp/CERTBOT_$CERTBOT_DOMAIN/RECORD_ID ]; then
        RECORD_ID=$(cat /tmp/CERTBOT_$CERTBOT_DOMAIN/RECORD_ID)
        rm -f /tmp/CERTBOT_$CERTBOT_DOMAIN/RECORD_ID
fi

# Remove the challenge TXT record from the zone
if [ -n "${ZONE_ID}" ]; then
    if [ -n "${RECORD_ID}" ]; then
        curl -s -X DELETE "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
                -H "X-Auth-Email: $EMAIL" \
                -H "X-Auth-Key: $API_KEY" \
                -H "Content-Type: application/json"
    fi
fi
