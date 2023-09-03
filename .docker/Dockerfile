FROM mattrayner/lamp:1404-php5-base

## ADD http://dbltek.com/update/goip_install-v1.30.1.tar.gz /
ADD .docker/goip_install-v1.30.1.tar.gz /
COPY .docker/goipinit.sh /goipinit.sh
COPY .docker/run.sh /run.sh
COPY .docker/supervisord-goip.conf /etc/supervisor/conf.d/supervisord-goip.conf

RUN mv /goip_install/goip /usr/local/goip \
    && ln -s /usr/local/goip /app/goip \
	&& sed -i "s/^\$dbuser=.*/\$dbuser='root';/" /usr/local/goip/inc/config.inc.php \
	&& sed -i "s/^\$dbpw=.*/\$dbpw='';/" /usr/local/goip/inc/config.inc.php \
    && chmod +x /goipinit.sh \
    && chmod +x /run.sh

EXPOSE 44444/udp
