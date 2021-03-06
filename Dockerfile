#Version : 0.0.1
#base ubuntu:latest 
#Development environment for Lajp (linux-apache-java-php)
#use Laravel Framework
#Application list
#		|-- apache2
#		|-- php5
#		|	|-- php5-mcrypt(for laravel)
#		|-- laravel
#		|-- openjdk-7-jdk
#		|-- git
#		|-- maven
#		|-- composer
FROM ubuntu
MAINTAINER apt-getyou "792122911@qq.com"
ENV REFRESHED_AT 2015-08-26

###ADD you code document
#VOLUME ["<mountpoint>"]

### www 
EXPOSE 80

RUN mv /etc/apt/sources.list  /etc/apt/sources.list_bak
ADD ./config/sources.list /etc/apt/
RUN apt-get update && apt-get -y upgrade

RUN apt-get install dialog
#######   install apache2
RUN apt-get install -y apache2 apache2-mpm-prefork apache2-utils

#######    install php5
RUN apt-get install -y php5 php5-cgi php5-cli php5-common php5-curl \
  php5-fpm php5-gd php5-intl php5-json php5-mcrypt php5-memcache php5-mysql \
  php5-odbc php5-sybase php5-pinba php5-redis php5-sqlite php5-xmlrpc \
  php5-mongo libapache2-mod-php5

##RUN apt-get install -y openjdk-7-jdk

RUN apt-get install -y vim git maven

#####配置 Apache 
RUN a2enmod rewrite
RUN php5enmod mcrypt
ADD ./config/apache2.conf /etc/apache2/
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

#####重启Apache 使配置生效
RUN service apache2 restart

#######   install wget
RUN apt-get install wget

WORKDIR /usr/src/

RUN  wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz
##### build jni
ADD ./config/jni /usr/src/jni/
RUN chmod +x ./jni/make.sh ./jni/set_path.sh

#RUN apt-get install -y aria2
#RUN aria2c --header="Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz
RUN tar -zxvf jdk-7u80-linux-x64.tar.gz -C /usr/src/

####composer and laravel 按需求安装 可能需要翻墙
RUN apt-get install -y curl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin -- --filename=composer
RUN composer config -g repositories.packagist composer http://packagist.phpcomposer.com
RUN composer global require "laravel/installer=~1.1"

#### install gcc
RUN apt-get install -y gcc

#### set PATH
RUN ["/bin/bash" , "./jni/set_path.sh"]

#CMD ["/bin/bash" , "./jni/set_path.sh"]

WORKDIR /usr/src/jni/

RUN ["/bin/bash" , "./make.sh"]
RUN cp liblajpmsgq.so /usr/lib/

WORKDIR /usr/src/
RUN rm jdk-7u80-linux-x64.tar.gz
RUN rm -fr /usr/src/jni

#### config for git
#RUN git config --global user.name "xxxxx"
#RUN git config --global user.email "xxxxx@xx.com"
# RUN ssh-keygen

RUN apt-get autoclean && apt-get clean && apt-get autoremove

