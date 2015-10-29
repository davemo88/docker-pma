from nginx:latest

RUN apt-get update \
    && apt-get install -y wget \
                          php5-fpm \
                          php5-mysql \
                          php5-mcrypt \
                          vim \
                          supervisor

RUN mkdir /etc/nginx/ssl
WORKDIR /etc/nginx/ssl
RUN openssl req -x509 -nodes -newkey rsa:2048 -keyout pma.key -out pma.crt -days 365 \
  -subj "/CN=bogus.net"

## reuse the default site directory
WORKDIR /usr/share/nginx/html/
ENV PHPMYADMIN_VERSION 4.5.1
RUN wget https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.gz \
     && tar -xzf phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.gz -C ./ \
     && rm phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.gz \
     && mv phpMyAdmin-${PHPMYADMIN_VERSION}-english pma \
     && mv pma/config.sample.inc.php pma/config.inc.php

## nginx runs as nginx instead of www-data
RUN sed -i "s/www-data/nginx/g" /etc/php5/fpm/pool.d/www.conf
## required for phpmyadmin
RUN php5enmod mcrypt

## replace default site with pma config
ADD default.conf /etc/nginx/conf.d/

ADD supervisord.conf /etc/supervisor/conf.d/

ADD cmd.sh /root/
CMD /root/cmd.sh