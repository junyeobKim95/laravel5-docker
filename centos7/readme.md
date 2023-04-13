# Prerequisite

## window docker 설치 및 환경 구축
1. 도커 설치
2. WSL2 환경 구축

    https://velog.io/@hanjuli94/%EC%9C%88%EB%8F%84%EC%9A%B0%EC%97%90%EC%84%9C-%EB%8F%84%EC%BB%A4-%EC%8B%A4%EC%8A%B5%ED%95%98%EA%B8%B0

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
$ systemctl restart sshd
```
## 4. mysql 설정
```bash
# 1. 초기 비밀번호 확인
$ grep 'temporary password' /var/log/mysqld.log
# 2. mysql 접속 후 임시로 보안수준 높은 비밀번호로 변경
mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('qntmxkDB12!@');
mysql> flush privileges;
# 3. 보안 수준 설정 및 쉬운 비밀번호로 변경
SHOW VARIABLES LIKE 'validate_password%';
mysql> use mysql;
SET GLOBAL validate_password_policy=LOW;
SET GLOBAL validate_password_length=4;
SET GLOBAL validate_password_mixed_case_count=0;
SET GLOBAL validate_password_number_count=0;
SET GLOBAL validate_password_special_char_count=0;
mysql> flush privileges;
mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('1234');
mysql> flush privileges;
# 4. 외부 접근 허용 후 적용
mysql> grant all privileges on *.* to 'root'@'%' identified by '1234';
mysql> flush privileges;
mysql> exit;
$ systemctl restart mysqld
```

## 5. HTTPS 설정
1. localhost에서 SSL를 적용해야합니다. 도커로 CentOS 환경이 구성되면 직접 터미널에서 적용하시면 됩니다.
    https://seul96.tistory.com/348
```bash
~$ openssl genrsa -des3 -out server.key 2048 # PW:1q2w3e4r
~$ openssl req -new -key server.key -out server.csr # 비밀번호 입력 후 그냥 엔터
~$ cp server.key server.key.origin
~$ openssl rsa -in server.key.origin -out server.key
~$ openssl x509 -req -days 750 -in server.csr -signkey server.key -out server.crt
~$ cp server.key /etc/httpd/conf/
~$ cp server.crt /etc/httpd/conf/
```

## 6. apache 시작
```bash
$ systemctl start httpd
```

## 7. laravel 실행
```bash
~$ stage_w # /home/centos/dev/stage/web 경로로 이동
web$ composer install
web$ npm install --save-dev
web$ npm run dev # 이 후 Front 소스를 개발 시 npm run watch로 실행
```

# ETC
## enviroment
Centos7 Apache2.4 php7.2 Mysql5.7 node8.10 python3.9.5

## port
1. 80 웹서버
2. 443 SSL
3. 3307 DB
4. 5222 SSH

## description
1. local에 파일을 두고 docker와 volumes을 맞추고 싶었지만 vendor, node_modules 파일들 때문에 페이지 렌더링 속도가 매우 느려 ssh로 접속해서 작업하는 방향으로 선택했습니다.
2. SSL 적용 후에도 419 error 통신이면 라라벨 실행 경로를 777권한으로 설정하고 아파치 재시작 해보세요.
3. mysql 비밀번호 권한 설정도 my.cnf에 넣을려 했지만 그러면 mysql 설치가 안되어 설치 후 수동으로 권한 설정 따로 해줘야함
4. 작업은 vscode 기준 remote-ssh 익스텐션을 이용해 개발을 하시면 됩니다.
5. 파이썬 크롤링을 위해 크롬 설치는 따로 해줘야합니다. https://passwd.tistory.com/entry/CentOS-Chrome-%EB%B0%8F-Selenium-%EC%84%A4%EC%B9%98
6. 크롬드라이버는 직접 설치해줘야합니다.( 크롬설치 > 크롬버전에 맞는 드라이버 설치 > /usr/bin 폴더에 위치 )
7. jenkins && java 11 설치 (선택)
```bash
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
yum install -y java-11-openjdk-devel.x86_64 jenkins
```