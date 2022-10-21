FROM php:8.1-alpine

## Attempt 1 ##
ENV COMPOSER_ALLOW_SUPERUSER=1

COPY --from=composer:2.4 /usr/bin/composer /usr/bin/composer

RUN apk --no-cache add bash git \
  && git clone https://github.com/vimeo/psalm.git /app/psalm

WORKDIR /app/psalm

RUN git checkout 4.29.0 \
    && composer install --no-progress \
    && composer bin box require --no-progress humbug/box:'^3.16.0'

COPY src/scoper.inc.php /app/psalm/scoper.inc.php

RUN bin/build-phar.sh \
    && cp build/psalm.phar /usr/local/bin/psalm \
    && chmod 755 /usr/local/bin/psalm \
    && ls -hal /usr/local/bin/psalm

## Used for debugging the build ##
#RUN psalm --version
#
#RUN php -r '$phar = new Phar("build/psalm.phar"); $phar->extractTo("psalm-phar-extracted");'
#RUN grep -r PSALM_VERSION psalm-phar-extracted
#RUN grep -r PHP_PARSER_VERSION psalm-phar-extracted

ENTRYPOINT /usr/local/bin/psalm
