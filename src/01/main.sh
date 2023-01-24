#!/bin/bash

if [[ $# -ne 6 ]]
then
    echo "Wrong number of arguments"
    exit 1
fi
if ! [[ -d $1 ]]
then
    echo "Wrong path"
    exit 1
fi
path=$1
if [[ ${path: 0:1} != "/" ]]
then
    echo "Wrong path it should be absolute"
    exit 1
fi
if [[ ${path: -1} != "/" ]]
then
    path+='/'
fi
reg1='^[1-9][0-9]+?$'
if ! [[ $2 =~ $reg1 ]]
then
    echo "Second argument is not an integer or less then 1"
    exit 1
fi
reg2='^[a-zA-Z]{1,7}$'
if ! [[ $3 =~ $reg2 ]]
then
    echo "Third argument is not only leters or more than 7 leters"
    exit 1
fi
if ! [[ $4 =~ $reg1 ]]
then
    echo "Fourth argument is not an integer or less then 1"
    exit 1
fi
reg3='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
if ! [[ $5 =~ $reg3 ]]
then
    echo "File name should be less then 7 letters and extansion should be betwen 1 and 3 letters"
    exit 1
fi
reg4='^[1-9][0-9]?[0]?kb$'
if ! [[ $6 =~ $reg4 ]]
then
    echo "Size should end on kb and not more than 100"
    exit 1
fi

source ./creator.sh
all_folders=$(create_folders $path $2 $3 $4 $5 $6)
create_files $path $2 $3 $4 $5 $6 $all_folders
