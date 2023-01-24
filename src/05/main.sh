#!/bin/bash

log_files=$(find . -name "log*.txt")

if [[ $# -ne 1 ]]
then
    echo "Program accept only one argument"
    exit 1
fi
if ! [[ $1 -ge 1 && $1 -le 4 ]]
then
    echo "Aargument is number between 1 and 4"
    exit 1
fi

source ./filter.sh
if [[ $1 == "1" ]]
then
    cod_sort $log_files
fi
if [[ $1 == "2" ]]
then
    all_uniq_ip $log_files
fi
if [[ $1 == "3" ]]
then
    error_requests $log_files
fi
if [[ $1 == "4" ]]
then
    error_uniq_ip $log_files
fi
