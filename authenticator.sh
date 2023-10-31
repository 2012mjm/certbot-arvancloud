#!/bin/bash

DIR="$(dirname "$0")"
source "$DIR/config.sh"

echo "CHALLENGE_DOMAIN: ${DOMAIN}"
echo "CHALLENGE_VALUE: ${RECORD_VALUE}"

RESPONSE=$(curl -s -X POST "https://napi.arvancloud.ir/cdn/4.0/domains/$DOMAIN/dns-records" \
    -H "Authorization: Apikey $API_KEY" \
    -H "Content-Type: application/json" \
    --data '{
        "value": {
            "text": "'"$RECORD_VALUE"'"
        },
        "type": "'"$RECORD_TYPE"'",
        "name": "'"$RECORD_NAME"'",
        "ttl": '"$TTL"',
        "cloud": false,
        "upstream_https": "default",
        "ip_filter_mode": {
            "count": "single",
            "order": "none",
            "geo_filter": "none"
        }
    }')

echo "$RESPONSE"
