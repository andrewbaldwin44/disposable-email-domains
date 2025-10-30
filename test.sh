#!/bin/bash

# This script checks if an email address is temporary.

# Read blocklist file into a bash array
mapfile -t blocklist < disposable_email_blocklist.conf

email="$1"
domain_part="${email#*@}"

declare -A blocked_domains
for d in "${blocklist[@]}"; do
  blocked_domains["$d"]=1
done
    
# Loop until we're on the last domain level
while [[ "$domain_part" == *.* ]]; do
  if [[ -n "${blocked_domains[$domain_part]:-}" ]]; then
    echo "false:Please enter your permanent email address."
    exit 1
  fi

  # Drop the left-most subdomain and try again (sub.mail.com -> mail.com)
  domain_part="${domain_part#*.}"
done

echo "true:"
exit 0
