echo "Testing NGINX"
nginx -t

echo "Starting PHP FPM in daemon mode"
php-fpm -D

echo "Starting NGINX"
nginx

# npm i && npm run dev