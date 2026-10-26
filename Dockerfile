FROM php:8.4-cli

ENV COMPOSER_ALLOW_SUPERUSER=1

# Install system dependencies, Node.js, and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libsqlite3-dev \
    libonig-dev \
    libxml2-dev \
    curl \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && docker-php-ext-install pdo pdo_mysql pdo_sqlite zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . .

# Create database file & directories prior to running scripts
RUN touch database/database.sqlite && chmod -R 777 database storage bootstrap/cache

# Install PHP dependencies without running premature Laravel discovery scripts
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Install Node dependencies and compile Vite assets
RUN npm install && npm run build

# Expose port and start server with migrations
CMD php artisan migrate --force && php artisan serve --host 0.0.0.0 --port $PORT
