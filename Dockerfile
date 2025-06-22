FROM dunglas/frankenphp:php8.4.8

ARG HOST_USER_ID=1000
ARG HOST_USER_NAME=app_user
ARG HOST_GROUP_ID=1000
ARG HOST_GROUP_NAME=app_user

COPY bin/* /usr/local/bin/

RUN apt-get update && apt-get install -y --no-install-recommends libxslt-dev zlib1g-dev g++ git libicu-dev libzip-dev zip librabbitmq-dev \
    && docker-php-ext-install intl opcache pdo pdo_mysql xsl bcmath \
    && pecl install redis \
    && pecl install apcu \
    && pecl install xdebug \
    && pecl install amqp \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN mkdir /app/ \
    && groupadd -f -g $HOST_GROUP_ID $HOST_GROUP_NAME \
    && useradd -m -d /home/$HOST_USER_NAME -s /bin/bash -g $HOST_GROUP_ID -u $HOST_USER_ID $HOST_USER_NAME || true \
    && echo "$HOST_USER_NAME  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $HOST_USER_NAME
WORKDIR /app/
