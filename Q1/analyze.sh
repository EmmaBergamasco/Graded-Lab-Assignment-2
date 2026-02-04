vi analyze.sh #open file analyze.sh in vi editor
i #insert mode

#!/bin/bash  #tells system to run script using the bash shell

if [ $# -ne 1 ]; then  #checks if the number of arguments is not equal to 1
    echo "Error: You must provide exactly one argument."  #error message
    exit 1  #script stops 
fi

if [ -f "$1" ]; then  #checks if file/directory does not exist (true if does not exist) 
    echo "Lines: $(wc -l < "$1")"  #prints lines
    echo "Words: $(wc -w < "$1")"  #prints words
    echo "Characters: $(wc -m < "$1")"  #prints characters 

elif [ -d "$1" ]; then  #checks if argument is a directory
    echo "Total files: $(find "$1" -type f | wc -l)"  #counts tot number of files 
    echo "Number of .txt files: $(find "$1" -type f -name '*.txt' | wc -l)"  #counts tot number of .txt files 

else  #handles any argument that is not a file or directory
    echo "Error: The argument is neither a file nor a directory."  #error message
    exit 1  #script stops 

fi  #ends conditional block 

Esc #exit insert mode 
:wq + Enter #save file and quit editor

chmod +x analyze.sh #runs script 
