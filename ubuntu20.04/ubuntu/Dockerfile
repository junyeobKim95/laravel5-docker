FROM ubuntu:20.04

ENV container docker
# 비대화형 설치
ENV DEBIAN_FRONTEND noninteractive

# -y 옵션은 설치여부 질문에 yes로 대답하라는 의미

# sudo 권한 설치
RUN apt-get update -y && apt-get install -y sudo vim xvfb
# netstat을 제공하는 패키지 찾기
RUN apt-cache search net-tools
# net-tools 설치
RUN apt-get install -y net-tools wget

# 한국 시간으로 설정
ENV TZ Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 작업 경로 생성
ADD /init.sh /
RUN chmod +x /init.sh
RUN ["/bin/bash","-c","/init.sh"]

# ssh 설치 && 환경설정 && crontab 설치
RUN apt-get install -y openssh-server
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN systemctl enable ssh
RUN apt-get install -y cron

# MariaDB 10.3 설치
RUN apt-get install -y mariadb-server-10.3

# MariaDB Configuration
RUN sed -i 's/bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf
RUN sed -i 's/skip-networking/#skip-networking/' /etc/mysql/mariadb.conf.d/50-server.cnf
RUN service mysql start && \
    mysql -u root -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '1234'; FLUSH PRIVILEGES;"

# apache 설치
RUN apt-get install -y apache2 && \
        service apache2 start

# # PHP 설치
RUN apt-get install -y php7.2 php-xml php-zip unzip php-curl php-mbstring php-iconv php-json php-mysql php-dev libapache2-mod-php
RUN apt-get install -y php-cli curl && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# # composer 설치
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Python3.9.5 설치
# Install dependencies
RUN apt-get install -y build-essential checkinstall
RUN apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
RUN cd /usr/src && \
        wget https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tgz && \
        tar -xf Python-3.9.5.tgz && \
        cd Python-3.9.5 && \
        ./configure --enable-optimizations && \
        make altinstall
# Python3.9.5를 기본 버전으로 설정
RUN update-alternatives --install /usr/bin/python python /usr/local/bin/python3.9 1 && \
        update-alternatives --set python /usr/local/bin/python3.9
# pip 설치
RUN cd /usr/local/bin && \
        wget https://bootstrap.pypa.io/get-pip.py && \
        python3.9 get-pip.py

# nodjs12.x && git 설치
RUN apt-get install -y git
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt-get install -y nodejs

# Firefox 설치 (mac m1칩에서 크롬으로 selenium이 불가능해 firefox이용)
RUN apt install firefox
RUN apt install firefox-geckodriver

# 최종 권한 부여
ADD /finnaly.sh /
RUN chmod +x /finnaly.sh
RUN ["/bin/bash","-c","/finnaly.sh"]

EXPOSE 80
EXPOSE 443
EXPOSE 3306
EXPOSE 22
EXPOSE 3000
EXPOSE 8080
EXPOSE 8100
EXPOSE 8200
EXPOSE 8300

CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]