FROM ubuntu:16.04

MAINTAINER Pavlo Ratushnyi <pavel.dhq@gmail.com>

ENV DEBIAN_FRONTEND="noninteractive"

ENV MYSQL_DB_NAME="database"
ENV DB_USER="user"
ENV DB_PASS="secret"

RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    && apt-get clean \
    && rm -fr /var/lib/apt/lists/* \
    && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
    && LC_ALL=C.UTF-8 add-apt-repository 'deb http://archive.ubuntu.com/ubuntu trusty universe'

RUN apt-get update && \
    apt-get install \
        curl \
        zip \
        unzip \
        apache2 \
        sudo \
        mysql-server-5.6 \
        libapache2-mod-php7.2 \
        php7.2 \
        php7.2-mysql \
        php7.2-cli \
        php7.2-gd \
        php7.2-curl \
        php7.2-zip \
        php7.2-dom \
        php7.2-simplexml \
        php7.2-xml \
        php7.2-mbstring -y && \
        apt-get autoclean -y && \
        apt-get autoremove -y && \
        a2enmod rewrite

COPY scripts /scripts
RUN chmod +x /scripts/*.sh

COPY bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

EXPOSE 80
WORKDIR /var/www/html
CMD ["/bootstrap.sh"]
