#!/bin/bash

DIR="$(dirname "$0")"
source "$DIR/config.sh"

log() {
    echo "$1" >> "$LOG_FILE"
}

log "DOMAIN: ${RECORD_DOMAIN}"

RECORDS=$(curl -s -X GET "https://napi.arvancloud.ir/cdn/4.0/domains/$RECORD_DOMAIN/dns-records" \
    -H "Authorization: Apikey $API_KEY")

RECORD_ID=$(echo "$RECORDS" | jq -r '.data[] | select(.type == "txt" and .name == "_acme-challenge").id')

log "Record ID: $RECORD_ID"

RESPONSE=$(curl -s -X DELETE "https://napi.arvancloud.ir/cdn/4.0/domains/$RECORD_DOMAIN/dns-records/$RECORD_ID" \
    -H "Authorization: Apikey $API_KEY")
    
log "$RESPONSE"
