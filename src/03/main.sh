#!/bin/bash

if [[ $# -ne 1 ]]
then
    echo "Wrong number of arguments"
    exit 1
fi
if [[ $1 == "1" || $1 == "2" || $1 == "3" ]]
then
    source ./clear.sh
    if [[ $1 == "1" ]]
    then
        log="log.txt"
        if [[ -e $log ]]
        then
            clear_by_log
        else
            echo "Log file do not exist, create log.txt"
        fi
    fi
    if [[ $1 == "2" ]]
    then
        clear_by_date
    fi
    if [[ $1 == "3" ]]
    then
        clear_by_mask
    fi
else
    echo "Arguments can be only 1 or 2 or 3"
    exit 1
fi
