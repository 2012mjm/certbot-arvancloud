API_KEY="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

DOMAIN=$(sed 's/.*\.\(.*\..*\)/\1/' <<< "${CERTBOT_DOMAIN}")
RECORD_NAME="_acme-challenge"
RECORD_TYPE="TXT"
RECORD_VALUE="$CERTBOT_VALIDATION"
TTL=120