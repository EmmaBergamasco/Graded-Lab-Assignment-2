vi metrics.sh #create metrics.sh using vi editor 
i #insert mode

#!/bin/bash

if [ ! -e "input.txt" ]; then  #check if file doesn't exist (! -e)
    echo "Error: input.txt file does not exist."  #print error message if condition is true
    exit 1  #exit script
fi

if [ ! -r "input.txt" ]; then  #check if file is not readable (! -r)
    echo "Error: input.txt file is not readable."  #print error message if condition is true
    exit 1  #exit script
fi

words=$(tr -cs '[:alnum:]' '\n' < input.txt | tr '[:upper:]' '[:lower:]' | sed '/^$/d')  #break text into one word per line and replace non-alphanumeric characters with newlines | convert all letters to lowercase

longest=$(echo "$words" | awk '{ print length, $0 }' | sort -nr | head -n1)  #print variable word and prepends each word with its length (awk {lenght}) | sort numerically (-n) in a reverse order (-r) so that the longest word is at the top (head -n1) 
echo "Longest word: $longest"  #print message 

shortest=$(echo "$words" | awk '{ print length, $0 }' | sort -n | head -n1)  #print variable word and prepends each word with its length (awk {lenght}) | sort numerically (-n) so that the shortest word is at the top (head -n1)
echo "Shortest word: $shortest"  #print message

total_chars=$(echo "$words" | awk '{ sum += length } END { print sum }')  #print variable word and add each word’s length to the running total sum; after processing all words, print the total number of characters (END {print sum})
total_words=$(echo "$words" | wc -l)  #print variable word and count number of lines (wc -l) 
avg=$(awk "BEGIN { printf \"%.2f\", $total_chars/$total_words }")  #execute a calculation without reading a file (BEGIN), format the result to 2 decimal places (%.2f), divide total characters by total words to obtain the average and store it in variable avg
echo "Average word length: $avg"  #print message

unique=$(echo "$words" | sort | uniq | wc -l)  #print variable word and sort it alphabetically | remove duplicates (uniq) | count number of lines (wc -l) and store it in variable unique 
echo "Total unique words: $unique"  #print message

Esc #exit insert mode 
:wq #save and quit 
chmod +x sync.sh #make script executable
