vi sync.sh  ##create sync.sh using vi editor 
i #insert mode

#!/bin/bash

# Check if both directory arguments are provided
if [ $# -ne 2 ]; then  #check if number of arguments is not equal to 2 (-ne 2) 
    echo "Error: Invalid number of arguments. Please provide exactly two directories."  #print error message if condition is true 
    exit 1  #exit script 
fi

dirA="$1"  #assign variable dirA
dirB="$2"  #assign variable dirB

# Check if directories exist
if [ ! -d "$dirA" ]; then  #check if directory A doesn't exist (! -d) 
    echo "Error: Directory '$dirA' does not exist."  #print error message if condition is true 
    exit 1  #exit script 
fi

if [ ! -d "$dirB" ]; then  #check if directory b doesn't exist (! -d) 
    echo "Error: Directory '$dirB' does not exist."  #print error message if condition is true 
    exit 1  #exit script 
fi

echo "Files only in $dirA:"  #print message
comm -23 <(ls "$dirA" | sort) <(ls "$dirB" | sort)  #list (ls) sorted (sort) files in each directory and compare them (comm) suppressing columns 2,3 (-23) so it shows only unique files in dirA

echo "Files only in $dirB:"  #print message
comm -13 <(ls "$dirA" | sort) <(ls "$dirB" | sort)  #list (ls) sorted (sort) files in each directory and compare them (comm) suppressing columns 11,3 (-13) so it shows only unique files in dirB

echo "Files present in both directories with differences:"  #print message
for file in "$dirA"/*; do
    filename=$(basename "$file")  #extract file name from a full path
    if [ -f "$dirB/$filename" ]; then  #check if exists a file with same name in dirB  
        if ! cmp -s "$dirA/$filename" "$dirB/$filename"; then  #check if files content differ (!) when comparing (cmp) them byte by byte - no output, only exit status (-s) 
            echo "$filename differs"  #print message if condition is true
        fi
    fi
done  #end of loop 

Esc #exit insert mode 
:wq #save and quit 
chmod +x sync.sh #make script executable
