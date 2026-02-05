vi patterns.sh  #create patterns.sh using vi editor
i  #insert mode

#!/bin/bash

if [ $# -ne 1 ]; then  #check if exactly one command-line argument is provided (-ne 1) 
    echo "Error: Please provide exactly one text file as argument."  #print error message if condition is true
    exit 1  #stop script
fi

file="$1"  #assign argument to variable file

if [ ! -e "$file" ]; then  #check if file does not exist (! -e)
    echo "Error: File '$file' does not exist."  #print error message if condition is true
    exit 1  #stop script
fi

if [ ! -r "$file" ]; then  #check if file is not readable (! -r)
    echo "Error: File '$file' is not readable."  #print error message if condition is true
    exit 1  #stop script
fi

words=$(tr -cs '[:alpha:]' '\n' < "$file" | tr '[:upper:]' '[:lower:]' | sed '/^$/d')  #every non-letter character becomes a newline (result: one word per line), convert text to lowercase, remove non-letter characters and empty lines

echo "$words" | grep '^[aeiou]\+$' > vowels.txt  #print variable words | search for lines containing only vowels and redirect output to vowels.txt

echo "$words" | grep '^[^aeiou]+$' > consonants.txt  #print variable words | search for lines containing only consonants and redirect output to consonants.txt

echo "$words" | grep '^[^aeiou][a-z]*[aeiou][a-z]*$' > mixed.txt  #print variable words | search for lines containing both vowels and consonants (starting with NOT [^] a vowel) and redirect output to consonants.txt mixed.txt

echo "Words with only vowels saved in vowels.txt"  #print message
echo "Words with only consonants saved in consonants.txt"  #print message
echo "Words with mixed letters (starting with consonant) saved in mixed.txt"  #print message

Esc  #exit insert mode
:wq  #save and quit
chmod +x patterns.sh  #make script executable
