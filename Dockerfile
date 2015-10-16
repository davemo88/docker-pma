from nginx:latest

RUN apt-get update \
    && apt-get install -y wget \
                          php5 \
                          php5-mysql

RUN mkdir -p /www/phpMyAdmin

ENV PHPMYADMIN_VERSION 4.5.0.2

RUN wget https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.bz2 \
     && tar -xvjf /phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.bz2 -C / \
     && rm /phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.bz2 \
     && rm -r /www \
     && mv /phpMyAdmin-${PHPMYADMIN_VERSION}-english /www
     # && mv /phpMyAdmin-${PHPMYADMIN_VERSION}-english/config.sample.inc.php /phpMyAdmin-${PHPMYADMIN_VERSION}-english/config.inc.php







CMD ["nginx", "-g", "daemon off;"]