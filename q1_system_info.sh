#!/bin/bash

# Q1: System Information Display
# This script prints basic system information in a readable format.

# Get required information
USERNAME=$(whoami)           # Current username
HOSTNAME=$(hostname)         # System hostname
CURRENT_DATETIME=$(date)     # Current date and time
OS_NAME=$(uname -s)          # Operating system name
CURRENT_DIR=$(pwd)           # Current working directory
HOME_DIR="$HOME"             # Home directory
USERS_ONLINE=$(who | wc -l)  # Number of users currently logged in
UPTIME_INFO=$(uptime)        # System uptime

# Bonus: disk usage and memory usage
DISK_USAGE=$(df -h / | tail -1)                         # Disk usage of root filesystem
MEMORY_USAGE=$(free -h | awk 'NR==2 {print $3 "/" $2}') # Used/total memory

# Display the information
echo "SYSTEM INFORMATION DISPLAY"
echo
echo "Username      : $USERNAME"
echo "Hostname      : $HOSTNAME"
echo "Date & Time   : $CURRENT_DATETIME"
echo "OS            : $OS_NAME"
echo "Current Dir   : $CURRENT_DIR"
echo "Home Dir      : $HOME_DIR"
echo "Users Online  : $USERS_ONLINE"
echo "Uptime        : $UPTIME_INFO"
echo "Disk Usage (/) : $DISK_USAGE"
echo "Memory Usage   : $MEMORY_USAGE"
