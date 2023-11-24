#!/bin/bash
# Ban users who send more than N requests per minute.

LOG_FILE="" # specify log file, e.g. "/var/log/nginx/access.log"
RATE_LIMIT=5

# Extract unique IP addresses and count their occurrences per second
IP_COUNTS=$(awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr)

while read -r COUNT IP; do
    if [ "$COUNT" -gt "$RATE_LIMIT" ]; then
        ufw deny from "$IP" to any
        echo "Blocked IP: $IP"
    fi
done <<< "$IP_COUNTS"





