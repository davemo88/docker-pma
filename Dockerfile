from nginx:latest

RUN apt-get update \
    && apt-get install -y wget \
                          php5-fpm \
                          php5-mysql \
                          php5-mcrypt \
                          phpmyadmin \
                          vim

# ENV PHPMYADMIN_VERSION 4.5.0.2

# RUN wget https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.gz \
#      && tar -xzf phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.gz -C / \
#      && rm /phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.gz \
#      && mkdir /www \
#      && mv /phpMyAdmin-${PHPMYADMIN_VERSION}-english /www/phpMyAdmin \
#      && mv /www/phpMyAdmin/config.sample.inc.php /www/phpMyAdmin/config.inc.php

ADD default.conf /etc/nginx/conf.d/

RUN echo "<?php phpinfo(); ?>" >> /usr/share/nginx/html/info.php

RUN sed -i 's/www-data/nginx/g' /etc/php5/fpm/pool.d/www.conf

RUN ln -s /usr/share/phpmyadmin /usr/share/nginx/html/

RUN php5enmod mcrypt && service php5-fpm restart

RUN nginx -s reload

CMD ["nginx", "-g", "daemon off;"]