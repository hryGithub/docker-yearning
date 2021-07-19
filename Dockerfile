FROM alpine:3.12

RUN sed -i "s@dl-cdn.alpinelinux.org@mirrors.aliyun.com@g" /etc/apk/repositories
RUN apk add --no-cache tzdata unzip libc6-compat curl
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" >> /etc/timezone \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

ENV VERSION=2.3.4
ENV WEBSITE='127.0.0.1' \
    MYSQL_ADDR='127.0.0.1' \
    MYSQL_PORT=3306 \
    MYSQL_DB='yearning'\
    MYSQL_USER='yearning' \
    MYSQL_PASSWORD='yearning' 

RUN mkdir /Yearning-go && cd /Yearning-go && wget $(curl -s https://api.github.com/repos/cookieY/Yearning/releases |grep browser_download_url |grep "$VERSION-"|awk '{print $2}'|sed 's@"@@g') \
    && unzip $(ls *.zip) && rm -rf *.zip __MACOSX 

ADD docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /Yearning-go

EXPOSE 8000

VOLUME ["/Yearning-go"]


ENTRYPOINT  ["sh", "/docker-entrypoint.sh"]

