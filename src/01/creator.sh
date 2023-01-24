#!/bin/bash

create_folders () {
    touch log.txt
    all_folders=""
    for (( i=0; i<$2; i++ ))
    do
        f_name=$3
        if [[ ${#f_name} -lt 4 ]]
        then
            f_size=${#f_name}
            diff=$(expr 4 - $f_size)
            for (( j=0; j<$diff; j++ ))
            do
                f_name+=${3: -1}
            done
        fi
        for (( j=0; j<$i; j++ ))
        do
            f_name+=${3: -1}
        done
        f_name+="_"
        f_name+=$(date +"%d%m%y")
        sudo mkdir -p $1$f_name
        f_name+="/"
        echo $1$f_name" $(date +'%e.%m.%Y')" >> log.txt
        all_folders+="$1$f_name"
        all_folders+=" "
    done
    echo $all_folders
}

create_files () {
    size="$(echo $6 | awk -F"kb" '{print $1}')KB"
    file_name_s="$(echo $5 | awk -F "." '{print $1}')"
    file_ext_s="$(echo $5 | awk -F "." '{print $2}')"
    all_files=""
    for (( i=0; i<$4; i++ ))
    do
        file_name=$file_name_s
        if [[ ${#file_name} -lt 4 ]]
        then
            f_size=${#file_name}
            diff=$(expr 4 - $f_size)
            for (( j=0; j<$diff; j++ ))
            do
                file_name+=${file_name_s: -1}
            done
        fi
        for (( j=0; j<$i; j++ ))
        do
            file_name+=${file_name_s: -1}
        done
        file_name+="_"
        file_name+=$(date +"%d%m%y")
        file_name+="."
        file_name+=$file_ext_s
        all_files+=$file_name
        all_files+=" "
    done
    j=0
    for arg in "$@"
    do
        j=$(( $j + 1 ))
        if [[ $j -gt 6 ]]
        then
            folder=$arg
            for file in $all_files
            do
                if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
                then
                    echo "No available disk space, you have only 1 Gb"
                    exit 1
                fi
                sudo fallocate -l $size $folder$file
                echo $folder$file" $(date +'%e.%m.%Y') "$size >> log.txt
            done
        fi
    done
}
