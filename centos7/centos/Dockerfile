# FROM centos:7.5.1804
FROM centos:8

# -y 옵션은 설치여부 질문에 yes로 대답하라는 의미

# sudo 권한 설치
RUN yum update -y
RUN yum install -y sudo epel-release
RUN yum provides netstat
RUN yum install -y net-tools wget

# 작업 경로 생성
ADD /init.sh /
RUN chmod +x /init.sh
RUN ["/bin/bash","-c","sh /init.sh"]

# ssh 설치 && 환경설정 && crontab 설치
RUN yum install -y net-tools vim openssh-server
RUN yum install -y cronie

# MYSQL5.7 설치
RUN yum erase mariadb*
RUN rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
RUN yum install -y http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
RUN yum install -y mysql-community-server

# apache 설치
RUN yum install -y httpd mod_ssl

# # PHP 설치
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
# PHP 7.2버전 설정
RUN yum-config-manager --enable remi-php72
RUN yum install -y php php-common php-fpm php-mysql php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml php-pecl-apc php-cli php-pear php-pdo
RUN yum install -y php-zip unzip

# # composer 설치
RUN curl -sS https://getcomposer.org/installer | php
RUN sudo mv composer.phar /usr/bin/composer

# Python3.9.5 설치
RUN yum install gcc openssl-devel bzip2-devel libffi-devel -y
RUN wget https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tgz && \ 
        tar -xvf Python-3.9.5.tgz && \
        cd Python-3.9.5 && \
        ./configure --enable-optimizations && \
        sudo make altinstall
RUN yum install python3-pip -y

# nodjs8.x && git 설치
RUN yum install -y gcc-c++ make
RUN curl -sL https://rpm.nodesource.com/setup_8.x | sudo -E bash -
RUN yum install -y nodejs git openssl

# 최종 권한 부여
ADD /finnaly.sh /
RUN chmod +x /finnaly.sh
RUN ["/bin/bash","-c","sh /finnaly.sh"]

EXPOSE 80
EXPOSE 443
EXPOSE 3306
EXPOSE 22
EXPOSE 3000
EXPOSE 8080
EXPOSE 8100
EXPOSE 8200
EXPOSE 8300

CMD ["/usr/sbin/httpd","-D","FOREGROUND"]