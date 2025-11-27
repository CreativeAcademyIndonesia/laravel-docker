FROM php:8.2-fpm

# Install packages
RUN apt-get update && apt-get install -y \
    git curl zip unzip libonig-dev libxml2-dev libzip-dev libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install pdo pdo_mysql mbstring xml intl zip

# Install composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Working directory
WORKDIR /var/www/html

# Copy Laravel source code
COPY . .

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Laravel OPTIMIZE
RUN php artisan key:generate || true
RUN php artisan config:cache || true
RUN php artisan route:cache || true
RUN php artisan view:cache || true

EXPOSE 9000
CMD ["php-fpm"]
