#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Error: You must provide exactly one argument."
    exit 1
fi

if [ -f "$1" ]; then
    echo "Lines: $(wc -l < "$1")"
    echo "Words: $(wc -w < "$1")"
    echo "Characters: $(wc -m < "$1")"

elif [ -d "$1" ]; then
    echo "Total files: $(find "$1" -type f | wc -l)"
    echo "Number of .txt files: $(find "$1" -type f -name '*.txt' | wc -l)"

else
    echo "Error: The argument is neither a file nor a directory."
    exit 1
fi
