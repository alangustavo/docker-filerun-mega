FROM php:8.2-apache

ENV FR_DB_HOST=db
ENV FR_DB_PORT=3306
ENV FR_DB_NAME=filerun
ENV FR_DB_USER=filerun 
ENV FR_DB_PASS=filerun
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_USER_ID=33
ENV APACHE_RUN_GROUP=www-data 
ENV APACHE_RUN_GROUP_ID=33
ENV LIBVIPS_VERSION="8.12.1" 
ENV LIBREOFFICE_VERSION="7.1.8" 
ENV PHP_VERSION_SHORT="8.2"


# UPDATE apt-get
RUN apt-get update
# INSTALL DEPENDENCIES
RUN apt-get install -y libmagickwand-dev --no-install-recommends

# INSTALL IMAGICK
RUN echo [Install ImageMagick] \
    && curl -o /tmp/im.tar.gz -L https://download.imagemagick.org/ImageMagick/download/ImageMagick.tar.gz \
    && tar zvxf /tmp/im.tar.gz -C /tmp \
    && cd /tmp/ImageMagick* \
    && ./configure --with-modules \
    && make && make install \
    && ldconfig /usr/local/lib

# RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends 
RUN pecl install imagick-3.7.0 && docker-php-ext-enable imagick
RUN service apache2 restart

# RUN echo extension=imagick.so > /usr/local/etc/php/conf.d/php-imagick.ini

# RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends 
# RUN printf "\n" | pecl install imagick
# RUN pecl install imagick && docker-php-ext-enable imagick

# INSTALL MEGA
#RUN apt-get install -y wget 
#RUN wget https://mega.nz/linux/repo/Debian_11/amd64/megacmd-Debian_11_amd64.deb -P /root/
#RUN apt-get install -y /root/megacmd-Debian_11_amd64.deb
