FROM php:8.2-fpm AS base

RUN apt-get update && apt-get install -y \
    zip unzip git curl libicu-dev libzip-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring intl zip

FROM composer:2 AS composer_stage

FROM base

COPY --from=composer_stage /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

EXPOSE 9000
CMD ["php-fpm"]
