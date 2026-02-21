#!/bin/bash

# Q2: File and Directory Manager
# This script helps manage files using a simple menu.

while true; do
    echo
    echo "file and directory manager "
    echo "1.List files in current directory"
    echo "2.Create a new directory"
    echo "3.Create a new file"
    echo "4.Delete a file"
    echo "5.Rename a file"
    echo "6.Search for a file"
    echo "7.Count files and directories"
    echo "8.Exit"
    echo
    
    read -p "Choose an option : " choice

    case $choice in
        1)
            # Shows files with human readable sizes [cite: 73]
            ls -lh
            ;;
        2)
            read -p "Enter name for new folder: " foldername
            mkdir "$foldername"
            echo "Folder created"
            ;;
        3)
            read -p "Enter name for new file: " filename
            touch "$filename"
            echo "File created"
            ;;
        4)
            read -p "Which file do you want to delete? " filename
            # Check if the file actually exists first [cite: 83, 87]
            if [ -f "$filename" ]; then
                read -p "Are you sure? (y/n): " confirm
                if [ "$confirm" == "y" ]; then
                    rm "$filename"
                    echo "File deleted."
                else
                    echo "Cancelled."
                fi
            else
                echo "Error: File not found."
            fi
            ;;
        5)
            read -p "Current file name: " oldname
            read -p "New file name: " newname
            if [ -f "$oldname" ]; then
                mv "$oldname" "$newname"
                echo "Renamed successfully."
            else
                echo "File not found."
            fi
            ;;
        6)
            read -p "What are you looking for?" pattern
            find . -name "$pattern"
            ;;
        7)
            # Simple way to count using wc -l [cite: 79, 155]
            file_count=$(ls -l | grep "^-" | wc -l)
            dir_count=$(ls -l | grep "^d" | wc -l)
            echo "Total Files: $file_count"
            echo "Total Folders: $dir_count"
            ;;
        8)
            echo "Closing program"
            exit 0
            ;;
        *)
            echo "Please pick a number between 1 and 8."
            ;;
    esac
done