FROM alpine:3.12

RUN sed -i "s@dl-cdn.alpinelinux.org@mirrors.aliyun.com@g" /etc/apk/repositories
RUN apk add --no-cache tzdata unzip libc6-compat
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" >> /etc/timezone \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

ENV VERSION=2.3.0
ENV WEBSITE='127.0.0.1'

RUN cd / && wget https://github.com/cookieY/Yearning/releases/download/v$VERSION/Yearning-$VERSION-GA-linux-amd64.zip \
    && unzip Yearning-$VERSION-GA.linux-amd64.zip && rm -rf Yearning-$VERSION-GA.linux-amd64.zip

ADD docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 8000
VOLUME ["/Yearning-go"]


ENTRYPOINT  ["sh", "/docker-entrypoint.sh"]

