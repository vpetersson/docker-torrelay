#!/bin/bash

# Assumes a key-value'ish pair
# $1 is the key and $2 is the value
function update_or_add {
  TORRC=/etc/tor/torrc
  FINDINFILE=$(grep -e "^$1.*$" $TORRC)

  echo "Adding $1 $2 to Torrc"

  # Append if missing.
  # Update if exist.
  if [ -z "$FINDINFILE" ]; then
    echo "$1 $2" >> $TORRC
  else
    sed -i "s/^$1.*/$1 $2/g" $TORRC
  fi
}

# Default communcation port
update_or_add 'ORPort' '9001'

# Disable Socks connections
update_or_add  'SocksPort' '0'

# Reject all exits. Only relay.
update_or_add 'Exitpolicy' 'reject *:*'

# Set $NICKNAME to the node nickname
if [ -n "$NICKNAME" ]; then
  update_or_add 'Nickname' "$NICKNAME"
else
  update_or_add 'Nickname' 'DockerTorrelay'
fi

# Set $CONTACTINFO to your contact info
if [ -n "$CONTACTINFO" ]; then
  update_or_add 'ContactInfo' "$CONTACTINFO"
else
  update_or_add 'ContactInfo' 'Anonymous'
fi

# Start the count on the first after midnight
update_or_add 'AccountingStart' 'month 1 00:01'

## Set monthly bandwidth limit.
# 750 Gigabytes per month (each way) is the default
if [ -n "$ACCOUNTINGMAX" ]; then
  update_or_add 'AccountingMax' "$ACCOUNTINGMAX"
else
  update_or_add 'AccountingMax' '750 GBytes'
fi

# Start Tor
chown -R tor:tor /home/tor
sudo -u tor -H /usr/sbin/tor -f /etc/tor/torrc
