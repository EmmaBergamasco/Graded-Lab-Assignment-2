vi log_analyze.sh  #create log file in vi editor
i  #insert mode

#!/bin/bash

if [ $# -ne 1 ]; then  #check if exactly one command-line argument is provided
    echo "Error: You must provide exactly one log file as an argument."
    exit 1
fi

logfile="$1"  #assign argument to logfile 

if [ ! -e "$logfile" ]; then  #check if file does not exists (! -e) 
    echo "Error: File '$logfile' does not exist." #throw error message if condition is true
    exit 1  #stops script
fi

if [ ! -r "$logfile" ]; then  #check if file is not readable (! -r) 
    echo "Error: File '$logfile' is not readable." #throw error message if condition is true
    exit 1  #stops script 
fi

total_entries=$(wc -l < "$logfile")  #count total number of log entries (wc -l)

info_count=$(grep -c "INFO" "$logfile")  #count and display (grep -c) number of info 
warning_count=$(grep -c "WARNING" "$logfile")  #count and display (grep -c) number of warning messages
error_count=$(grep -c "ERROR" "$logfile")  #count and display (grep -c) number of error messages

recent_error=$(grep "ERROR" "$logfile" | tail -n 1)  #display (grep) most recent (tail -n 1) error message 

report_file="logsummary_$(date +%F).txt"  #generate a report file with current date in YYYY-MM-DD format

echo "Total log entries: $total_entries" >> "$report_file"  #print (echo) total number of entries appending it (>>) to file report_file
echo "INFO messages: $info_count" >> "$report_file"  #print (echo) total number of info messages appending it (>>) to file report_file
echo "WARNING messages: $warning_count" >> "$report_file"  #print (echo) total number of warning messages appending it (>>) to file report_file
echo "ERROR messages: $error_count" >> "$report_file"  #print (echo) total number of error messages appending it (>>) to file report_file
echo "Most recent ERROR: $recent_error" >> "$report_file"  #print (echo) most recent error message appending it (>>) to file report_file

Esc #exit insert mode
:wq  #save and quit 

chmod +x log_analyze.sh #make script executable so it can run on terminal 
