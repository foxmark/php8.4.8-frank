FROM dunglas/frankenphp:php8.4.8

COPY bin/* /usr/local/bin/

RUN apt-get update && apt-get install -y --no-install-recommends \
    git libzip-dev zip librabbitmq-dev \
    && docker-php-ext-install intl pdo pdo_mysql xsl bcmath \
    && pecl install redis \
    && pecl install apcu \
    && pecl install xdebug \
    && pecl install amqp \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

