#!/bin/bash

if [[ $# -ne 1 ]]
then
    echo "Program accept only one argument"
    exit 1
fi
if ! [[ -f $1 ]]
then
    echo "File do not exist"
    exit 1
fi
if ! [[ -d  "/etc/nginx/" ]]
then
    echo "Nginx is not instaled"
    exit 1
fi

goaccess $1 -p goaccess.conf -o index.html
path=$(pwd)
echo "events {
    worker_connections  1024;
}
http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    server {
        listen 80;
        server_name test.nginx.com;
        root $path;
        index index.html;
    }
    sendfile        on;
    keepalive_timeout  65;
}" > nginx.conf
sudo cp nginx.conf /etc/nginx/nginx.conf
sudo nginx -t
sudo systemctl restart nginx
