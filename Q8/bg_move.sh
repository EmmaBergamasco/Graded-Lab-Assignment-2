vi bg_move.sh  #create bg_move.sh using vi editor
i  #insert mode

#!/bin/bash

if [ $# -ne 1 ]; then  #check if exactly one command-line argument is provided (-ne 1)
    echo "Error: Please provide exactly one directory as argument."  #print error message
    exit 1  #stop script
fi

dir="$1"  #assign argument to variable dir

if [ ! -d "$dir" ]; then  #check if the provided path is not a directory (! -d)
    echo "Error: Directory '$dir' does not exist."  #print error message if condition is true 
    exit 1  #stop script
fi

backup_dir="$dir/backup"  #define path for backup subdirectory
mkdir -p "$backup_dir"  #create backup directory (mkdir) (-p ensures no error if it already exists)

for file in "$dir"/*; do  #look for each file in directory
    if [ -f "$file" ]; then  #check if it is a regular file
        mv "$file" "$backup_dir" &  #move (mv) the file to backup directory in background (&)
        pid=$!  #$! stores the PID of the last background process
        echo "Moving '$file' in background with PID: $pid"  #display the PID of the background process
    fi
done  

wait  #wait for all background processes to finish
echo "All files moved to $backup_dir"  #print completion message

Esc  #exit insert mode
:wq  #save and quit
chmod +x bg_move.sh  #make script executable
