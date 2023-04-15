# How to Install
1. 원하는 운영체제 폴더로 이동
2. docker-compose up -d

# Enviroment
Apache2.4 php7.2 Mysql5.7 node8 python3.9.5

# Description
1. ubuntu18.04로 환경 구축
2. centos는 사용 하지말고 참고만
3. selenium은 os가 mac m1이면 fireFox, window면 chrome, 이유는 amd64 운영체제와 가상환경에서 크롬문제가 있기 때문이라고 파악
 - ubuntu 버전을 올려도 안됨 (버전업을 하면 laravel5에서도 문제가 생김 - ubuntu20.04부터는 기본 php7.4부터 설치되기 때문)
 - chrome, chromedriver 버전 최신부터 ~ 89버전까지 설치해봐도 안됨
 - 그냥 mac m1 docker에서는 코딩만 하는게 좋다고 생각, 가상화 영역에 호환 안되는 부분이 많은 거 같음
4. Jenkins && Java 11(선택사항) 설치

# Develop
## centos7
1. docker terminar에서 systemctl 명령어를 입력하면 failed to get d-bus connection no such file or directory 에러 반환
2. centos7 환경의 문제로 보이며 window에서는 그래도 실행되다가 window업데이트와 동시에 막힘
3. centos는 2024년에 지원종료 예정이라 그냥 히스토리 파일로 작성됨
## ubuntu18.04
1. OS에 따른 "win/mac" 주석 검색 후 수정 후 설치

## Need Improvement
1. application의 컨테이너화
2. OS에 따른 환경변수 처리