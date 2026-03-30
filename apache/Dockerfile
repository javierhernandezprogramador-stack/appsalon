FROM php:8.2-apache

ENV APACHE_DOCUMENT_ROOT /var/www/html/public

#Configuración para poner a public como directorio principal
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf

#permisos de apache
RUN printf '<Directory /var/www/html/public>\n\
    AllowOverride All\n\
    Require all granted\n\
    </Directory>\n' >> /etc/apache2/apache2.conf

#asegurar index
RUN echo "DirectoryIndex index.php index.html" >> /etc/apache2/apache2.conf

# Activar modo rewrite
RUN a2enmod rewrite

#Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# INSTALAR SERVIDOR SSH
RUN apt-get update && apt-get install -y openssh-server libpng-dev libjpeg-dev libfreetype6-dev

# Activar extensiones
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install gd mysqli pdo pdo_mysql

# configuracion ssh

RUN mkdir -p /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config


# permitir login por password
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

#Exponer puerto ssh??? 22
EXPOSE 22

#INICIAR EL CONTAINER
CMD service ssh start && apache2-foreground
