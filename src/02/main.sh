#!/bin/bash

if [[ $# -ne 3 ]]
then
    echo "Wrong number of arguments"
    exit 1
fi
reg1='^[a-zA-Z]{1,7}$'
if ! [[ $1 =~ $reg1 ]]
then
    echo "Third argument is not only leters or more than 7 leters"
    exit 1
fi
reg2='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
if ! [[ $2 =~ $reg2 ]]
then
    echo "File name should be less then 7 letters and extansion should be betwen 1 and 3 letters"
    exit 1
fi
reg3='^[1-9][0-9]?[0]?Mb$'
if ! [[ $3 =~ $reg3 ]]
then
    echo "Size should end on Mb and not more than 100"
    exit 1
fi

source ./creator.sh
create $1 $2 $3
