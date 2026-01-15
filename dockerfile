# Utiliser l'image officielle PHP
FROM php:8.3-alpine

# Installer les dépendances nécessaires
RUN apk add --no-cache \
    bash \
    curl \
    icu-dev \
    libzip-dev \
    zlib-dev \
    oniguruma-dev \
    autoconf \
    g++ \
    make \
    postgresql-dev

# Installer les extensions PHP nécessaires (PDO + PostgreSQL)
RUN docker-php-ext-install \
    pdo \
    pdo_pgsql \
    pgsql \
    intl \
    zip

# Installer Composer
COPY --from=composer:2.8 /usr/bin/composer /usr/bin/composer

# Définir le répertoire de travail
WORKDIR /var/www

# Exposer le port 8010
EXPOSE 8010

# Commande de démarrage du serveur PHP intégré
CMD ["php", "-S", "0.0.0.0:8010", "-t", "public"]

