FROM jenkins
MAINTAINER james@example.com
ENV REFRESHED_AT 2016-06-01

# 루트 유저로 전환
USER root

# 패키지 매니져 업데이트 (-qq는 메시지를 표시하지 않는다는 뜻)
RUN apt-get -qq update && apt-get install -qq sudo

# 젠킨스의 모든 사용자에게 관리자 권한을 부여함
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# 도커 최신버젼 다운로드
RUN wget http://get.docker.com/builds/Linux/x86_64/docker-latest.tgz

# 도커 최신버젼 압축 해제
RUN tar -xvzf docker-latest.tgz

# /usr/bin 안에 도커 바이너리를 모두 이동
RUN mv docker/* /usr/bin/

# 젠킨스 유저로 전환 
USER jenkins

# 필요한 플러그인들을 설치
RUN /usr/local/bin/install-plugins.sh junit git git-client ssh-slaves greenballs chucknorris antisamy-markup-formatter build-timeout credentials-binding timestamper ws-cleanup ant gradle workflow-aggregator github-organization-folder pipeline-stage-view subversion matrix-auth pam-auth ldap email-ext mailer docker-plugin
