#!/bin/bash

# Simple Backup Script
# This script allows user to take backup of a folder
# Either as normal copy or as compressed file

echo " BACKUP PROGRAM "

# Ask user for source folder
echo "Enter the folder you want to backup:"
read src

# Check if folder exists
if [ ! -d "$src" ]; then
    echo "Oops! That folder does not exist."
    exit 1
fi

# Ask for destination folder
echo "Enter where you want to save the backup:"
read dest

# If destination doesn't exist, create it
if [ ! -d "$dest" ]; then
    echo "Destination not found. Creating it..."
    mkdir -p "$dest"
fi

# Ask backup type
echo "Choose backup type:"
echo "1 - Normal Copy"
echo "2 - Compressed (tar.gz)"
read option

# Get current date and time for naming
time_stamp=$(date +%Y%m%d_%H%M%S)
start=$(date +%s)

echo "Starting backup..."
echo "Source folder: $src"
echo "Backup location: $dest"

if [ "$option" -eq 1 ]; then
    
    backup_name="backup_$time_stamp"
    cp -r "$src" "$dest/$backup_name"
    
elif [ "$option" -eq 2 ]; then
    
    backup_name="backup_$time_stamp.tar.gz"
    tar -czf "$dest/$backup_name" "$src"
    
else
    echo "Invalid option selected!"
    exit 1
fi

status=$?

end=$(date +%s)
total_time=$((end - start))

if [ $status -eq 0 ]; then
    echo "Backup successful!"
    echo "File name: $backup_name"
    echo "Stored at: $dest"
    
    size=$(du -sh "$dest/$backup_name" | awk '{print $1}')
    echo "Backup size: $size"
    echo "Time taken: $total_time seconds"
else
    echo "Something went wrong. Backup failed."
fi