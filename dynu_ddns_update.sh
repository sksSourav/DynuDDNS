#!/bin/bash

HOSTNAME="$1"
API_KEY="$2"
INTERVAL="${3:-300}"   # default 300s if not given

if [[ -z "$HOSTNAME" || -z "$API_KEY" ]]; then
  echo "Usage: $0 <HOSTNAME> <API_KEY> [INTERVAL]"
  exit 1
fi

while true; do
  echo "Updating DNS for $HOSTNAME..."
  curl -s "https://api.dynu.com/nic/update?hostname=$HOSTNAME&myip=$(curl -s ifconfig.me)&password=$API_KEY"
  echo "Sleeping $INTERVAL seconds..."
  sleep "$INTERVAL"
done