FROM cimage/php70-apache:latest

# Remove red warning text
ENV DEBIAN_FRONTEND "noninteractive"


# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
	php composer-setup.php && \
	php -r "unlink('composer-setup.php');" && \
	install --mode=0755 composer.phar /usr/local/bin/composer && \
	rm composer.phar
    
# install git and zip for composer
RUN	apt-get update && \
    apt-get install -qy git zip unzip php-pclzip


# install yaml
RUN apt-get update && \
    apt-get install -qy libyaml-dev && \
    printf "\n" | pecl install yaml && \
    bash -c "echo extension=yaml.so >> /usr/local/etc/php/php.ini"


# create entry in /etc/hosts
RUN bash -c "echo 127.0.0.1 local.dbwebb.se >> /etc/hosts"

# create directories so apache2 can find them
RUN mkdir /var/www/website /var/www/website/htdocs
VOLUME ["/var/www/website"]


# download config files for apache2
RUN mkdir /config && \
    curl -o /config/apache-env https://raw.githubusercontent.com/dbwebb-se/website/master/config/apache-env && \
    curl -o /config/apache-redirects https://raw.githubusercontent.com/dbwebb-se/website/master/config/apache-redirects && \
    curl -o /config/apache-rewrites https://raw.githubusercontent.com/dbwebb-se/website/master/config/apache-rewrites
    
# download apache virtualhost dbwebb file and overwrite 000-default.conf
RUN curl -o /config/dbwebb.se.conf https://raw.githubusercontent.com/dbwebb-se/website/master/config/apache/docker/dbwebb.se.conf && \
    bash -c "cat /config/dbwebb.se.conf > /etc/apache2/sites-available/000-default.conf"

# possible solution for apache2 warning "could not determin server domain name" - not working, get warning about mpm
#RUN bash -c "echo ServerName localhost | tee /etc/apache2/apache2.conf"

# allow rewrite htaccess and expires
RUN	a2enmod rewrite && a2enmod expires && service apache2 restart

# expose port 80 to network
EXPOSE 80
