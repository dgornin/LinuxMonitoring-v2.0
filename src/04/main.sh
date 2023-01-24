#!/bin/bash

if [[ $# -eq 0 ]]
then
    time="$(date "+%Y-%m-%d") 00:00:00 $(date +%z)"
    for (( i=1; i<6; i++))
    do
        logs_n=$(shuf -n1 -i 100-1000)
        plus_sec=$(shuf -i 10-60 -n1)
        for (( j=0; j<$logs_n; j++ ))
        do
            ip="$(shuf -n1 -i 1-255).$(shuf -n1 -i 1-255).$(shuf -n1 -i 1-255).$(shuf -n1 -i 1-255)"
            ans=$(shuf -n1 cods.txt)
            method=$(shuf -n1 methods.txt)
            date="[$(date -d "$time + $plus_sec seconds"  +'%d/%b/%Y:%H:%M:%S %z')]"
            url=$(shuf -n1 urls.txt)
            protocol=$(shuf -n1 protocols.txt)
            code=$(shuf -n1 cods.txt)
            agent=$(shuf -n1 agents.txt)
            logfile_date=$(date -d "$time + $plus_sec seconds"  +'%d_%m_%Y')
            (( plus_sec+=$(shuf -i 10-60 -n1) ))
            final=$ip" - - "$date" \""$method" "$url" "$protocol"\" "$code" \"-\" \""$agent"\""
            log_file_name="log_"$logfile_date".txt"
            echo $final >> $log_file_name
        done
    time="$(date -d "$time + $i days" +'%Y-%m-%d')"    
    done
else
    echo "Program do not acept any arguments"
    exit 1
fi

# 200 - OK
# 201 - CREATED
# 400 - BAD_REQUEST
# 401 - UNAUTHORIZED
# 403 - FORBIDDEN
# 404 - NOT_FOUND
# 500 - INTERNAL_SERVER_ERROR
# 501 - NOT_IMPLEMENTED
# 502 - BAD_GATEWAY
# 503 - SERVICE_UNAVAILABLE
