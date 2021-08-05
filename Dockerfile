FROM wordpress:5.2.3-php7.3-fpm-alpine

RUN apk add --update --no-cache sudo gmp-dev zlib-dev libpng-dev libjpeg-turbo-dev freetype-dev libzip-dev && \
  #もともとベースイメージに入ってるコンフィグをカスタマイズ
  docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ --with-freetype-dir=/usr/include/ && \
  docker-php-ext-install gd gmp zip mysqli pdo_mysql && \
  docker-php-source delete && \
  sed -e "s/xfs:x:33/xfs:x:82/" -e "s/www-data:x:82/www-data:x:33/" -i /etc/group && \
  sed -e "s/xfs:x:33:33/xfs:x:82:82/" -e "s/www-data:x:82:82/www-data:x:33:33/" -i /etc/passwd