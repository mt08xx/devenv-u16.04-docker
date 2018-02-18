FROM php:5.6-apache
RUN yes | pecl install xdebug-2.5.5 \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo \
'xdebug.remote_enable=1\n'\
'xdebug.remote_autostart=1\n'\
'xdebug.remote_connect_back=1\n'\
'xdebug.remote_port=9000\n'\
>> /usr/local/etc/php/conf.d/xdebug.ini
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN docker-php-ext-install gettext && docker-php-ext-enable gettext
RUN a2enmod rewrite
RUN a2enmod ssl
ADD ssl.conf /etc/apache2/sites-available/ssl.conf
RUN a2ensite ssl
EXPOSE 443
