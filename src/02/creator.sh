#!/bin/bash

create () {
    touch log.txt
    start_path=$(pwd)
    start_time=$(date +'%Y-%m-%d %H:%M:%S')
    start_sec=$(date +'%s%N')
    echo "Script started at $start_time" >> log.txt
    echo "Script started at $start_time"
    dir_name=$1
    dir_date="$(date +"%d%m%y")"
    if [[ ${#dir_name} -lt 5 ]]
    then
        for (( i=${#dir_name}; i<5; i++ ))
        do
            dir_name+=${1: -1}
        done
    fi
    dirs_n=$(echo $(( 1 + $RANDOM % 100 )))

    for (( i=0; i<$dirs_n; i++ ))
    do
        random_dir="$(compgen -d / | shuf -n1)"
        file_n="$(shuf -i 1-50 -n1)"
        if [[ $random_dir == "/bin" || $random_dir == "/sbin" ]]
        then
            dirs_n=$(( $dirs_n + 1 ))
            continue
        fi
        dir_path=$random_dir"/"$dir_name"_"$dir_date
        dir_name+=${1: -1}
        sudo mkdir -p $dir_path 2>/dev/null
        dir_path+="/"
        echo $dir_path" $(date +'%e.%m.%Y')" >> log.txt
        file_ext=$(echo $2 | awk -F. '{print $2}')
        file_name=$(echo $2 | awk -F. '{print $1}')
        file_last=${file_name: -1}
        if [[ ${#file_name} -lt 5 ]]
        then
            for (( j=${#file_name}; j<5; j++ ))
            do
                file_name+=$file_last
            done
        fi
        for (( j=0; j<$file_n; j++ ))
        do
            if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
            then
                echo "No available disk space, you have only 1 Gb"
                j=$file_n
                i=$dirs_n
                continue
            fi
            full_name=$file_name"_"$dir_date"."$file_ext
            file_name+=$file_last
            sudo fallocate -l $3 $dir_path$full_name 2>/dev/null
            echo $dir_path$full_name" $(date +'%e.%m.%Y') "$3 >> log.txt
        done
    done

    cd $start_path
    end_time=$(date +'%Y-%m-%d %H:%M:%S')
    end_sec=$(date +'%s%N')
    echo "Script finished at $end_time" >> log.txt
    echo "Script finished at $end_time"
    dif_sec=$((( $end_sec - $start_sec ) / 100000000 ))
    echo "Script wore executed for $dif_sec secconds" >> log.txt
    echo "Script wore executed for $dif_sec secconds"
}
