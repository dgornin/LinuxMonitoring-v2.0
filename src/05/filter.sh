#!/bin/bash

cod_sort () {
    for var in "$@"
    do
        echo "In file: $var"
        sort -k 9 $var
        new_log="cod_sort_"${var: 2:${#var}}
        sort -k 9 $var > $new_log
    done
}

all_uniq_ip () {
    for var in "$@"
    do
        echo "In file: $var"
        awk '{print $1}' $var | sort -nu
        new_log="all_uniq_ip_"${var: 2:${#var}}
        awk '{print $1}' $var | sort -nu > $new_log
    done
}

error_requests () {
    for var in "$@"
    do
        echo "In file: $var"
        awk '$9 ~ /[45][0-9][0-9]/' $var
        new_log="error_requests_"${var: 2:${#var}}
        awk '$9 ~ /[45][0-9][0-9]/' $var > $new_log
    done
}

error_uniq_ip () {
    for var in "$@"
    do
        echo "In file: $var"
        awk '$9 ~ /[45][0-9][0-9]/' $var | awk '{print $1}' | sort -nu
        new_log="error_uniq_ip_"${var: 2:${#var}}
        awk '$9 ~ /[45][0-9][0-9]/' $var | awk '{print $1}' | sort -nu > $new_log
    done
}
