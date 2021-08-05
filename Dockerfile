FROM vimeo/psalm-github-actions:latest

## Build a phar for psalm ##
RUN apk --no-cache add bash \
  && git clone https://github.com/vimeo/psalm.git /app/psalm \
  && cd /app/psalm \
  && git checkout 4.9.2 \
  && composer install \
  && bin/build-phar.sh \
  && cp build/psalm.phar /usr/local/bin/psalm \
  && /usr/local/bin/psalm --version
