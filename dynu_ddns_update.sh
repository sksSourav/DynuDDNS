#!/bin/bash

USERNAME="$1"
PASSWORD="$2"
HOSTNAME="$3"
INTERVAL="${4:-300}"   # default 300s if not given

if [[ -z "$HOSTNAME" || -z "$PASSWORD" || -z "$HOSTNAME" ]]; then
  echo "Usage: $0 <USERNAME> <PASSWORD> <HOSTNAME> [INTERVAL]"
  exit 1
fi

while true; do
  echo "Updating DNS for $HOSTNAME..."
  IPv4=$(curl -4 -s ifconfig.me)
  IPv6=$(curl -6 -s ifconfig.me)
  wget -qO- "https://api.dynu.com/nic/update?hostname=$HOSTNAME&myip=$IPv4&myipv6=$IPv6&username=$USERNAME&password=$PASSWORD"
  echo "Sleeping $INTERVAL seconds..."
  sleep "$INTERVAL"
done