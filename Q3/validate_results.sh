vi validate_results.sh  #create validate_results.sh file using vi editor 
i  #insert mode 

#!/bin/bash

if [ ! -e "marks.txt" ]; then  #check if marks.txt doesn't exist (! -e)
    echo "Error: marks.txt file does not exist."  #throw error message if condition is true 
    exit 1  #stop script
fi

if [ ! -r "marks.txt" ]; then  #check if marks.txt is not readable (! -r)
    echo "Error: marks.txt file is not readable."  #throw error message if condition is true 
    exit 1  #stop script
fi

# Initialize counters
fail_one_count=0  #initialize count to 0 of failing students 
pass_all_count=0  #initialize count to 0 of passing students 

echo "Students who failed in exactly ONE subject:"  #print (echo) message

while IFS=',' read -r roll name m1 m2 m3  #while loop that read (read -r) file variables based on Internal Field Separator (setting it as comma due to file format) 
do
    fail_count=0
    
    if [ "$m1" -lt 33 ]; then  #check if mark in subject 1 (m1) is less than 33 (-lt 33) using test command []
        fail_count=$((fail_count + 1))   #increment fail count if condition is true 
    fi

    if [ "$m2" -lt 33 ]; then  #check if mark in subject 2 (m2) is less than 33 (-lt 33) using test command []
        fail_count=$((fail_count + 1))  #increment fail count if condition is true 
    fi

    if [ "$m3" -lt 33 ]; then  #check if mark in subject 3 (m3) is less than 33 (-lt 33) using test command []
        fail_count=$((fail_count + 1))  #increment fail count if condition is true 
    fi

    if [ "$fail_count" -eq 1 ]; then  #check if fail_count is equal to 1 (-eq 1) using test command []
        echo "$roll $name"  #print variables roll and name if condition is true 
        fail_one_count=$((fail_one_count + 1))  #increment fail_one_count if condition is true 
    fi

    if [ "$fail_count" -eq 0 ]; then  #check if fail_count is equal to 0 (-eq 0) using test command []
        pass_all_count=$((pass_all_count + 1))  #increment pass_all_count if condition is true 
    fi

done < marks.txt  #while loop reads one line from marks.txt

echo "Students who passed in ALL subjects:"

while IFS=',' read -r roll name m1 m2 m3  #read again using while loop 
do
    if [ "$m1" -ge 33 ] && [ "$m2" -ge 33 ] && [ "$m3" -ge 33 ]; then  #check if mark in subjects 1,2,3 is greater than or equal to 33 (-ge 33) 
        echo "$roll $name"  #print variables roll and name if condition is true 
    fi
done < marks.txt

echo "Count of students who failed in exactly one subject: $fail_one_count"  #prints fail_one_count 
echo "Count of students who passed all subjects: $pass_all_count"  #prints pass_all_count 

Esc  #exit insert mode
:wq  #save and quit 
chmod +x validate_results.sh  #make script executable 
