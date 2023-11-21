# Write a program to implement an address book with options given below: 
# a) Create address book. b) View address book. c) Insert a record. d) Delete a record. e) Modify a record. f) Exit


#!/bin/bash

ADDRESS_BOOK_FILE="address_book.txt"

# Function to create an address book
create_address_book() {
    > "$ADDRESS_BOOK_FILE"
    echo "Address book created."
}

# Function to view address book
view_address_book() {
    if [ -s "$ADDRESS_BOOK_FILE" ]; then
        echo "Address Book:"
        cat "$ADDRESS_BOOK_FILE"
    else
        echo "Address book is empty."
    fi
}

# Function to insert a record
insert_record() {
    echo "Enter name:"
    read name
    echo "Enter address:"
    read address
    echo "$name, $address" >> "$ADDRESS_BOOK_FILE"
    echo "Record inserted."
}

# Function to delete a record
delete_record() {
    view_address_book
    if [ -s "$ADDRESS_BOOK_FILE" ]; then
        echo "Enter the line number of the record to delete:"
        read lineno
        if [ "$lineno" -ge 1 ] && [ "$lineno" -le "$(wc -l < "$ADDRESS_BOOK_FILE")" ]; then
            sed -i "${lineno}d" "$ADDRESS_BOOK_FILE"
            echo "Record deleted."
        else
            echo "Invalid line number."
        fi
    else
        echo "No records to delete."
    fi
}

# Function to modify a record
modify_record() {
    view_address_book
    if [ -s "$ADDRESS_BOOK_FILE" ]; then
        echo "Enter the line number of the record to modify:"
        read lineno
        if [ "$lineno" -ge 1 ] && [ "$lineno" -le "$(wc -l < "$ADDRESS_BOOK_FILE")" ]; then
            echo "Enter new name:"
            read name
            echo "Enter new address:"
            read address
            sed -i "${lineno}s/.*/$name, $address/" "$ADDRESS_BOOK_FILE"
            echo "Record modified."
        else
            echo "Invalid line number."
        fi
    else
        echo "No records to modify."
    fi
}

# Main program loop
while true; do
    echo "Options:"
    echo "a) Create address book"
    echo "b) View address book"
    echo "c) Insert a record"
    echo "d) Delete a record"
    echo "e) Modify a record"
    echo "f) Exit"
    
    read -p "Enter your choice: " choice
    
    case $choice in
        a) create_address_book ;;
        b) view_address_book ;;
        c) insert_record ;;
        d) delete_record ;;
        e) modify_record ;;
        f) echo "Exiting." ; exit ;;
        *) echo "Invalid choice. Please select a valid option." ;;
    esac
done
