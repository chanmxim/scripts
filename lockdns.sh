#!/bin/bash

# Check if the user actually provided a Wi-Fi name
if [ -z "$1" ]; then
    echo "Error: You must provide a Wi-Fi network name."
    echo "Usage: ./lockdns.sh \"WIFI name\""
    exit 1
fi

TARGET_WIFI="$1"

echo "Locking down DNS for: $TARGET_WIFI..."

# Tell NetworkManager to permanently ignore the router's DNS for this network
sudo nmcli connection modify "$TARGET_WIFI" ipv4.ignore-auto-dns yes ipv6.ignore-auto-dns yes

# Restart the connection to apply the strict rules immediately
sudo nmcli connection up "$TARGET_WIFI"

echo "Done. Traffic is now routing globally through systemd-resolved."
