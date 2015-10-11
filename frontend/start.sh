#!/usr/bin/env bash

cp /usr/share/nginx/html/js/config.js.dist /tmp/config.js
sed -i "s/%api_host%/${API_HOST}/" /tmp/config.js
sed -i "s/%api_port%/${API_PORT}/" /tmp/config.js
mv /tmp/config.js /usr/share/nginx/html/js/config.js

nginx -g'daemon off;'
