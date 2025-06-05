FROM php:8.1-apache

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
RUN apt-get update && apt-get install -y curl unzip git \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Copy app code to container
COPY . /var/www/html/

# Set working directory to Yii2
WORKDIR /var/www/html/yii2-app-basic

# Run composer install to get vendor/ folder
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Set Apache DocumentRoot to Yii2 entry point
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/yii2-app-basic/web|g' /etc/apache2/sites-available/000-default.conf

# Fix permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80


# FROM php:8.1-apache

# # Install PHP extensions
# RUN docker-php-ext-install pdo pdo_mysql mysqli

# # Enable Apache mod_rewrite
# RUN a2enmod rewrite

# # Copy Yii2 app to Apache's default directory
# COPY . /var/www/html/

# # Set Apache DocumentRoot to Yii2's entry point
# RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/yii2-app-basic/web|g' /etc/apache2/sites-available/000-default.conf

# # Set working directory
# WORKDIR /var/www/html/yii2-app-basic

# # Fix permissions new 1
# RUN chown -R www-data:www-data /var/www/html \
#     && chmod -R 755 /var/www/html

# EXPOSE 80

# FROM php:8.1-apache

# # Install PHP extensions
# RUN docker-php-ext-install pdo pdo_mysql mysqli

# # Enable Apache mod_rewrite
# RUN a2enmod rewrite

# # Copy Yii2 app to container 
# COPY . /var/www/html/

# # Set working directory i
# WORKDIR /var/www/html/

# # Permissions
# RUN chown -R www-data:www-data /var/www/html \
#     && chmod -R 755 /var/www/html

# EXPOSE 80
