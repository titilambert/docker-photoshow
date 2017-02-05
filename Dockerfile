FROM debian:testing

RUN apt-get update && apt-get install -y apache2 && rm -rf /var/lib/apt/lists/* && apt-get clean
RUN apt-get update && apt-get install -y libapache2-mod-php && rm -rf /var/lib/apt/lists/* && apt-get clean
RUN apt-get update && apt-get install -y php-gd php7.0-xml && rm -rf /var/lib/apt/lists/* && apt-get clean
RUN apt-get update && apt-get install -y git-core && rm -rf /var/lib/apt/lists/* && apt-get clean
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/* && apt-get clean
RUN git clone https://github.com/thibaud-rohmer/PhotoShow.git /var/www/photoshow
RUN cd /var/www/photoshow/ && git checkout d7cae5fd208f71cbd7ff8445c4158840a9d2936d
RUN cd /var/www/photoshow/ && rm -rf /var/www/photoshow/.git*

RUN cd /var/www/photoshow && sed -i -e 's#$config->photos_dir.\+#$config->photos_dir = "/opt/photoshow/photos";#' config.php
RUN cd /var/www/photoshow && sed -i -e 's#$config->ps_generated.\+#$config->ps_generated = "/opt/photoshow/generated";#' config.php

RUN echo '<VirtualHost *:80>' > /etc/apache2/conf-enabled/photoshow.conf
RUN echo '  DocumentRoot "/var/www/photoshow"' >> /etc/apache2/conf-enabled/photoshow.conf
RUN echo '</VirtualHost>' >> /etc/apache2/conf-enabled/photoshow.conf

RUN mkdir -p /opt/photoshow/photos
RUN mkdir -p /opt/photoshow/generated
RUN chown www-data:www-data -R /opt/photoshow

ENV APACHE_RUN_USER=www-data
ENV APACHE_PID_FILE=/var/run/apache2.pid
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_LOG_DIR=/var/log/apache2
ENV APACHE_RUN_DIR=/var/run/
ADD startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 80 443

ENTRYPOINT /usr/local/bin/startup.sh
