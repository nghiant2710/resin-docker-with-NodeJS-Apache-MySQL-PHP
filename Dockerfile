FROM resin/rpi-raspbian:latest

RUN apt-get update

RUN apt-get install -y supervisor curl wget
 
# Install NodeJS Mysql Apache PHP
RUN apt-get install -y apache2 libapache2-mod-php5 php5 php5-gd mysql-client mysql-server

RUN wget http://nodejs.org/dist/v0.10.28/node-v0.10.28-linux-arm-pi.tar.gz
RUN tar -xvzf node-v0.10.28-linux-arm-pi.tar.gz

ENV PATH $PATH:/node-v0.10.28-linux-arm-pi/bin
# Set registry in case it doestn't work
#RUN npm config set registry "http://registry.npmjs.org/"

ADD hello.php /var/www/html/
ADD supervisor.conf /etc/supervisor/conf.d/

ENV PATH $PATH:/usr/bin
EXPOSE 80

# Start supervisor to monitor apache and mysql services
RUN echo 'supervisord && /bin/bash' > /start
RUN chmod +x /start