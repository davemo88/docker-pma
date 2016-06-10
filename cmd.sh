if [ $MYSQL_HOST ]; then
    sed -i "s/localhost/$MYSQL_HOST/g" pma/config.inc.pph
elif [ $MYSQL_PORT_3306_TCP_ADDR ]; then
    sed -i "s/localhost/$MYSQL_PORT_3306_TCP_ADDR/g" pma/config.inc.php
fi
/usr/bin/supervisord
