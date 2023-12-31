#!/bin/bash

DIR="$(dirname "$0")"
LOG_FILE="$DIR/script.log"

API_KEY="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

RECORD_DOMAIN=$(sed 's/.*\.\(.*\..*\)/\1/' <<< "${CERTBOT_DOMAIN}")
RECORD_NAME="_acme-challenge"
RECORD_TYPE="TXT"
TTL=120

# Google
DNS_SERVER="8.8.8.8"

MAX_ATTEMPTS=20
SLEEP_TIME=30
# Total time to wait for DNS propagation = max_attempts * sleep_time = 20 * 30s = 600s = 10 min
