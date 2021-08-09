#!/bin/bash

sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev unzip

mkdir nginx && cd nginx/

wget http://nginx.org/download/nginx-1.15.1.tar.gz

wget https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/dev.zip

tar -zxvf nginx-1.15.1.tar.gz

unzip dev.zip

cd nginx-1.15.1/

./configure --with-http_ssl_module --without-http_gzip_module --add-module=../nginx-rtmp-module-dev

make 

sudo make install

cat >> /usr/local/nginx/conf/nginx.conf <<EOF
rtmp {
    server {
        listen 1935;
        chunk_size 4096;

        application live {
            live on;
            record off;
        }
    }
}

EOF

sudo /usr/local/nginx/sbin/nginx 
