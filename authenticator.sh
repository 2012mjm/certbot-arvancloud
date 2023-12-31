#!/bin/bash

DIR="$(dirname "$0")"
source "$DIR/config.sh"

log() {
    echo "$1" >> "$LOG_FILE"
}

log "CHALLENGE_DOMAIN: ${RECORD_DOMAIN}"
log "CHALLENGE_VALUE: ${CERTBOT_VALIDATION}"

RESPONSE=$(curl -s -X POST "https://napi.arvancloud.ir/cdn/4.0/domains/$RECORD_DOMAIN/dns-records" \
    -H "Authorization: Apikey $API_KEY" \
    -H "Content-Type: application/json" \
    --data '{
        "value": {
            "text": "'"$CERTBOT_VALIDATION"'"
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

log "$RESPONSE"

attempt_counter=0
while true; do
    if [[ $attempt_counter = $MAX_ATTEMPTS ]]; then
        log "DNS propagation time: $(($attempt_counter * $SLEEP_TIME))s"
        log "Max attempts reached. The creation of the Let's Encrypt certificate (with DNS verification) will fail"
        break
    fi

    for d in $(dig "@$DNS_SERVER" -t txt +short "$RECORD_NAME.$RECORD_DOMAIN"); do
        if [[ "$d" = "\"$CERTBOT_VALIDATION\"" ]]; then
            log "DNS propagation time: $(($attempt_counter * $SLEEP_TIME))s"
            break 2
        fi
    done

    attempt_counter=$(($attempt_counter + 1))

    # Sleep to make sure the change has time to propagate over to DNS
    sleep $SLEEP_TIME
done
