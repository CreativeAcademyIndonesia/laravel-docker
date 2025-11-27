FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git curl zip unzip libonig-dev libxml2-dev libzip-dev libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install pdo pdo_mysql mbstring xml intl zip

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# SALIN LARAVEL KE DALAM IMAGE
COPY . .

# INSTALL COMPOSER DI DALAM IMAGE (sebelum bind mount menimpa)
RUN composer install --no-dev --optimize-autoloader

RUN php artisan key:generate || true

EXPOSE 9000

CMD ["php-fpm"]
