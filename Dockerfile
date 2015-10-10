FROM ubuntu

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  php5-fpm \
  nginx

ADD ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
ADD ./docker/nginx/sites-enabled/ /etc/nginx/sites-enabled

ADD ./docker/php-fpm/php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD ./docker/php-fpm/pool.d/ /etc/php5/fpm/pool.d

RUN mkdir -p /etc/php5/cli; ln -s /etc/php5/fpm/php.ini /etc/php5/cli/php.ini
RUN sed -i "s/;date.timezone =/date.timezone = Europe\/Berlin/" /etc/php5/fpm/php.ini

ADD app/ /app

EXPOSE 80 9000

WORKDIR /app
