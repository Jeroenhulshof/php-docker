FROM php:8.2-fpm-alpine

RUN apk add --no-cache --update nginx npm;

RUN docker-php-ext-install mysqli pdo pdo_mysql

COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./config/startup.sh /startup.sh

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN mkdir -p /app
RUN mkdir -p /app/public

# COPY ./src /app/public

RUN chown -R www-data: /app/public

WORKDIR /app/public

EXPOSE 8888
EXPOSE 5173

CMD sh /startup.sh