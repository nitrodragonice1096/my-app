FROM php:8.4-cli

# Install system dependencies & PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . .

# Install PHP packages
RUN composer install --no-dev --optimize-autoloader

# Create empty SQLite database file and give full read/write permissions
RUN touch database/database.sqlite && chmod -R 777 database

# Run database migrations and start server
CMD php artisan migrate --force && php artisan serve --host 0.0.0.0 --port $PORT
