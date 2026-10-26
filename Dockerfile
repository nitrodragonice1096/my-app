FROM php:8.4-cli

# Install system dependencies, Node.js, and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    curl \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && docker-php-ext-install pdo pdo_mysql zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Install Node dependencies and compile Vite assets
RUN npm install && npm run build

# Create SQLite database file and set permissions for runtime
RUN touch database/database.sqlite && chmod -R 777 database storage

# Run database migrations and start server
CMD php artisan migrate --force && php artisan serve --host 0.0.0.0 --port $PORT
