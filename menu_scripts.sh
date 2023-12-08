#!/bin/bash

declare -A names
declare -i continueInt
declare -ir TRUE=1

main() {
    clear

    continueInt=$TRUE  # Initialize continueInt

    while [ "$continueInt" -eq $TRUE ]; do
        # Display the menu options
        echo "1. Option 1: Print Hello"
        echo "2. Option 2: Display Date"
        echo "3. Option 3 (Sub-menu)"
        echo "4. Option 4: List Files"
        echo "5. Option 5 (Sub-menu)"
        echo "6. Option 6: Print Goodbye"
        echo "0. Exit"

        # Get user input for the choice
        read -p "Enter your choice: " choice

        # Process the user's choice
        case $choice in
            1)
                echo "Hello! This is option 1."
                ;;
            2)
                echo "The current date is: $(date)"
                ;;
            3)
                option3_submenu
                ;;
            4)
                echo "Listing files in the current directory:"
                ls
                ;;
            5)
                option5_submenu
                ;;
            6)
                echo "Goodbye! This is option 6."
                ;;
            0)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Invalid choice"
                ;;
        esac
    done

    exit 0
}

option3_submenu() {
    echo "1. Sub-option 1: Print Something"
    echo "2. Sub-option 2: Display Calendar"
    echo "3. Sub-option 3: Count Files"
    read -p "Enter your choice: " sub_choice

    case $sub_choice in
        1)
            echo "Something!"
            ;;
        2)
            cal
            ;;
        3)
            echo "Number of files in the current directory: $(ls | wc -l)"
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
}

option5_submenu() {
    echo "1. Sub-option 1: Print Welcome"
    echo "2. Sub-option 2: Show Disk Usage"
    echo "3. Sub-option 3: Print File Contents"
    read -p "Enter your choice: " sub_choice

    case $sub_choice in
        1)
            echo "Welcome!"
            ;;
        2)
            df -h
            ;;
        3)
            read -p "Enter the filename: " filename
            cat "$filename"
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
}

main
