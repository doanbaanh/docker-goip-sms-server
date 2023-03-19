FROM php:5.6-apache

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions \
        mbstring \
        mysqli \
        sockets

RUN apt-get update \
	&& apt-get install -f --no-install-recommends -y default-libmysqlclient-dev \
	&& apt-get -y clean \
	&& rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/lib/x86_64-linux-gnu/libmysqlclient.so /usr/lib/x86_64-linux-gnu/libmysqlclient.so.18

# ADD http://dbltek.com/update/goip_install-v1.30.1.tar.gz /
ADD ./goip_install-v1.30.1.tar.gz /
COPY ./entrypoint.sh /entrypoint.sh
RUN mv /goip_install/goip /usr/local/goip \
    && ln -s /usr/local/goip /var/www/html/goip \
	&& sed -i "s/^\$dbhost=.*/\$dbhost='goip-sms-server-db';/" /usr/local/goip/inc/config.inc.php \
	&& sed -i "s/^\$dbuser=.*/\$dbuser='root';/" /usr/local/goip/inc/config.inc.php \
	&& sed -i "s/^\$dbpw=.*/\$dbpw='12345';/" /usr/local/goip/inc/config.inc.php \
    && chmod +x /entrypoint.sh

EXPOSE 44444/udp

ENTRYPOINT ["/entrypoint.sh"]
