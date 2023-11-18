FROM php:8.2-fpm-alpine
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN apk add --no-cache --update nginx npm;

COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./config/startup.sh /startup.sh

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN mkdir -p /app
RUN mkdir -p /app/public

# COPY ./src /app/public

RUN chown -R www-data: /app/public

WORKDIR /app/public

RUN chmod +x /usr/local/bin/install-php-extensions && \
    IPE_GD_WITHOUTAVIF=1 install-php-extensions pdo_mysql redis

EXPOSE 8888
EXPOSE 5173

CMD sh /startup.sh