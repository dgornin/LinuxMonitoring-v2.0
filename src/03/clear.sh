#!/bin/bash

clear_by_log () {
    logs=$(cat log.txt | awk '{print $1}')
    for i in $logs
    do
        if [[ ${i: 0:1 } == "/" ]]
        then
            sudo rm -rf $i
        fi
    done
}

clear_by_date () {
    echo "Enter the date and time (example: YYYY-MM-DD HH:MM)"
    read -p "Write start date and time: " start
    echo "Enter the date and time (example: YYYY-MM-DD HH:MM)"
    read -p "Write end date and time: " end
    files=`sudo find / -newermt "$start" ! -newermt "$end"  2>/dev/null | sort -r`
    for i in $files
    do
        last=$(echo $i | awk -F"/" '{ print $NF }')
        if [[ $last =~ "." ]]
        then
            sudo rm -rf $i
        fi
    done
}

clear_by_mask () {
    echo "input slould be like: foldername_$(date '+%d%m%y') or filename_$(date '+%d%m%y').ext"
    read -p "enter the namemask: " nameMask
    name=$(echo $nameMask | awk -F"_" '{ print $1 }')
    end=$(echo $nameMask | awk -F"_" '{ print $2 }')
    sudo rm -rf $(find / -type f -name "*$name*$end" 2>/dev/null)
    sudo rm -rf $(find / -type d -name "*$name*$end" 2>/dev/null)
}
