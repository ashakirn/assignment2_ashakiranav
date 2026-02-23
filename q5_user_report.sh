#!/bin/bash

# Simple user and security report script

echo " user statistics "

# total accounts in /etc/passwd
TOTAL_USERS=$(wc -l < /etc/passwd)

# split system vs normal users by UID threshold
SYSTEM_USERS=$(awk -F: '$3 < 1000 {c++} END {print c+0}' /etc/passwd)
REGULAR_USERS=$(awk -F: '$3 >= 1000 {c++} END {print c+0}' /etc/passwd)

# how many are logged in right now
LOGGED_IN=$(who | wc -l)

echo "Total users:            $TOTAL_USERS"
echo "System users (UID < 1000):  $SYSTEM_USERS"
echo "Regular users (UID >= 1000): $REGULAR_USERS"
echo "Currently logged in:    $LOGGED_IN"

echo
echo "=== REGULAR USER DETAILS ==="
printf "%-15s %-6s %-25s %-15s\n" "Username" "UID" "Home" "Shell"

awk -F: '$3 >= 1000 {
    printf "%-15s %-6s %-25s %-15s\n", $1, $3, $6, $7
}' /etc/passwd

echo
echo "=== SECURITY CHECKS ==="

echo "Users with UID 0 (root-equivalent):"
awk -F: '$3 == 0 {print " -", $1}' /etc/passwd

echo
echo "Checking for accounts without usable passwords..."
if sudo awk -F: '($2 == "" || $2 == "*" || $2 == "!") {print $1}' /etc/shadow 2>/dev/null; then
    :
else
    echo "Could not read /etc/shadow (try running this script with sudo)."
fi
