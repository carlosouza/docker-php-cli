FROM php:7.4-cli

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/

COPY ./conf.d $PHP_INI_DIR/conf.d/

RUN install-php-extensions  xdebug redis memcached mongodb mysqli pdo_mysql protobuf \
	&& docker-php-ext-enable xdebug redis memcached mongodb mysqli pdo_mysql protobuf 

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

WORKDIR /var/www

EXPOSE 80 9001

CMD [ "php", "-S", "0.0.0.0:80", "-t ." ]
