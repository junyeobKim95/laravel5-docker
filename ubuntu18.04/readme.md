# Prerequisite

## window docker 설치 및 환경 구축
1. 도커 설치
2. WSL2 환경 구축

    https://velog.io/@hanjuli94/%EC%9C%88%EB%8F%84%EC%9A%B0%EC%97%90%EC%84%9C-%EB%8F%84%EC%BB%A4-%EC%8B%A4%EC%8A%B5%ED%95%98%EA%B8%B0

3. macOS m1 칩일 경우 docker-compose.yml에 있는 주석을 해제 후 설치

# How to use
## 1. docker-compose up -d

## 2. docker 터미널로 접속

## 3. ssh 설정
```bash
# ssh 설치 && 환경설정
$ su -
$ vi /etc/ssh/sshd_config
# Port 22번 주석 해제
# PermitRootLogin 부분을 yes로 변경
# passwd root 명령어로 비밀번호 설정
$ passwd root
$ service sshd restart
```
## 4. mysql 설정
```bash
# 1. mysqld.cnf 권한 변경
$ sudo chmod 644 /etc/mysql/mysql.conf.d/mysqld.cnf
```

## 5. HTTPS 설정
1. localhost에서 SSL를 적용해야합니다. 도커로 Ubuntu 환경이 구성되면 직접 터미널에서 적용하시면 됩니다.
    https://seul96.tistory.com/348
```bash
~$ openssl genrsa -des3 -out server.key 2048 # PW:1q2w3e4r
~$ openssl req -new -key server.key -out server.csr # 비밀번호 입력 후 그냥 엔터
~$ cp server.key server.key.origin
~$ openssl rsa -in server.key.origin -out server.key
~$ openssl x509 -req -days 750 -in server.csr -signkey server.key -out server.crt
~$ cp server.key /etc/apache2/
~$ cp server.crt /etc/apache2/
```

## 6. laravel 실행
```bash
~$ stage_w # /home/centos/dev/stage/web 경로로 이동
web$ composer install
web$ npm install --save-dev
web$ npm run prod # 이 후 Front 소스를 개발 시 npm run watch로 실행
```
※ 만약 다 설치 후 메인페이지까지 접속했는데 ajax api에서 500에러가 나타나면 pdo_mysql.so를 지우고 재설치해보세요
```bash
~$ wget https://www.php.net/distributions/php-7.2.24.tar.gz
~$ tar -xvzf php-7.2.24.tar.gz
~$ cd php-7.2.24/ext/pdo_mysql/
 $ phpize
 $ ./configure
 $ make
 $ sudo cp modules/pdo_mysql.so /usr/lib/php/20170718/
```

# ETC
## enviroment
Ubuntu18.04 Apache2.4 php7.2 Mysql5.7 node8.10 python3.9.5

## port
1. 80 웹서버
2. 443 SSL
3. 3307 DB
4. 5222 SSH

## description
1. local에 파일을 두고 docker와 volumes을 맞추고 싶었지만 vendor, node_modules 파일들 때문에 페이지 렌더링 속도가 매우 느려 ssh로 접속해서 작업하는 방향으로 선택했습니다.
2. SSL 적용 후에도 419 error 통신이면 라라벨 실행 경로를 777권한으로 설정하고 아파치 재시작 해보세요.
3. 작업은 vscode 기준 remote-ssh 익스텐션을 이용해 개발을 하시면 됩니다. https://inpa.tistory.com/entry/VSCode-%F0%9F%92%BD-Remote-SSH-%EC%82%AC%EC%9A%A9%EB%B2%95-AWS%EC%97%90-%EC%A0%91%EC%86%8D%ED%95%B4%EC%84%9C-%EC%BD%94%EB%94%A9%ED%95%98%EC%9E%90

4. 파이썬 크롤링을 위해 크롬&크롬드라이버 설치는 따로 해줘야합니다. https://passwd.tistory.com/entry/CentOS-Chrome-%EB%B0%8F-Selenium-%EC%84%A4%EC%B9%98
```bash
~$ wget https://chrome-versions.com/google-chrome-stable-110.0.5481.77-1.deb
~$ apt install ./google-chrome-stable-110.0.5481.77-1.deb
~$ wget https://chromedriver.storage.googleapis.com/110.0.5481.77/chromedriver_linux64.zip
~$ unzip chromedriver_linux64.zip
~$ cp chromedriver /usr/bin
```
5. jenkins 설치 (선택사항)
```bash
~$ apt-get install -y gnupg2 curl
~$ url -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
~$ sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
~$ apt-get install -y openjdk-8-jdk jenkins
~$ service jenkins start
```
6. ssh-keygen으로 git과 ssh연결해야함
7. 각 repository 마다 log 폴더가 지정 되어 있음
