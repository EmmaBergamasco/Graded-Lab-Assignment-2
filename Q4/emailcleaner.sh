vi emailcleaner.sh  #create emailcleaner.sh using vi editor
i  #insert mode 

#!/bin/bash

if [ ! -e "emails.txt" ]; then  #check if file doesn't exist (! -e) 
    echo "Error: emails.txt file does not exist."  #print error message if condition is true 
    exit 1  #stop script 
fi

if [ ! -r "emails.txt" ]; then  #check if file is not readable (! -r) 
    echo "Error: emails.txt file is not readable."  #print error message if condition is true 
    exit 1  #stop script 
fi

grep '^[a-zA-Z0-9]\+@[a-zA-Z]\+\.com$' emails.txt > valid.txt  #search (grep) file for valid emails (pattern: [letters/digits], [@], [letters], [.com]) and redirect it (>) to valid.txt

grep -v '^[a-zA-Z0-9]\+@[a-zA-Z]\+\.com$' emails.txt > invalid.txt  #search (grep) file for invalid emails by inverting match (-v) and redirect it (>) to invalid.txt

sort valid.txt | uniq > temp.txt  #sort file alphabetially, remove consecutive duplicates (uniq) from valid.txt and redirect output to a temporary file 
mv temp.txt valid.txt  #rename temp.txt to valid.txt

echo "Valid emails saved in valid.txt"  #print message
echo "Invalid emails saved in invalid.txt"

Esc  #exit insert mode 
:wq  #save and quit 
chmod +x emailcleaner.sh  #make script executable 
