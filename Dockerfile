FROM alpine:3.16

RUN sed -i "s@dl-cdn.alpinelinux.org@mirrors.aliyun.com@g" /etc/apk/repositories \
    && apk add --no-cache expect perl perl-dbd-mysql tzdata unzip libc6-compat curl \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" >> /etc/timezone \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

ENV VERSION=3.0.7
ENV WEBSITE='127.0.0.1' \
    MYSQL_ADDR='127.0.0.1' \
    MYSQL_PORT=3306 \
    MYSQL_DB='yearning'\
    MYSQL_USER='yearning' \
    MYSQL_PASSWORD='yearning' 

RUN cd /opt && wget $(curl -s https://api.github.com/repos/cookieY/Yearning/releases |grep browser_download_url |grep "$VERSION-"|awk '{print $2}'|sed 's@"@@g') \
    && unzip $(ls *.zip) && rm -rf *.zip __MACOSX && mv Yearning yearning 

ADD docker-entrypoint.sh /docker-entrypoint.sh
ADD pt-online-schema-change /usr/local/bin/pt-online-schema-change

RUN chmod +x /usr/local/bin/pt-online-schema-change

WORKDIR /opt/yearning

EXPOSE 8000

VOLUME ["/opt/yearning"]


ENTRYPOINT  ["sh", "/docker-entrypoint.sh"]

