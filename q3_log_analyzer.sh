
#!/bin/bash

# Question Log File Analyzer
# Analyzes the provided log file for security and traffic stats

# ch Check if a filename was provided
if [ -z "$1" ]; then
    echo "Usage: ./q3_log_analyzer.sh <logfile>"
    exit 1
fi

LOGFILE="$1"

# 2. Check if the file exists
if [ ! -f "$LOGFILE" ]; then
    echo "Error: File '$LOGFILE' not found."
    exit 1
fi

echo "--- RESULTS FOR $LOGFILE ---"

#  Count Total Entries
# Using wc -l to count every line in the log
TOTAL_ENTRIES=$(wc -l < "$LOGFILE")
echo "Total Entries: $TOTAL_ENTRIES"

#  List Unique IPs and Count them
echo -e "\nIPs found:"
awk '{print $1}' "$LOGFILE" | sort -u
UNIQUE_COUNT=$(awk '{print $1}' "$LOGFILE" | sort -u | wc -l)
echo "Total Unique IPs: $UNIQUE_COUNT"

# Status Code Summary
echo -e "\nStatus Codes:"
# $NF is a trick that always looks at the VERY LAST column
awk '{print $NF}' "$LOGFILE" | sort | uniq -c | awk '{print $2 ": " $1 " requests"}'

# Top 3 Spammers (Most frequent IPs)
echo -e "\nTop 3 Spammers:"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -n 3 | awk '{print $2 " - " $1 " requests"}'