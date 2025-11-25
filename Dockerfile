FROM php:8.2-fpm
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpq-devlibonig-dev libxml2-dev libzip-dev libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install pdo pdo_mysql mbstring xml intl zip

COPY --from-composer:2 /usr/bin/compose /usr/bin/composer 

WORKDIR /var/www/html 
EXPOSE 9000
CMD ["php-fpm"]