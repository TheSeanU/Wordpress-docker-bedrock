FROM php:8.2.0-fpm-alpine
RUN docker-php-ext-install mysqli

WORKDIR /app
COPY . /app

RUN curl -sL https://getcomposer.org/installer | php -- --install-dir /usr/bin --filename composer

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh