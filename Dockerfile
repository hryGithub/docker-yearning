FROM alpine:3.12

RUN sed -i "s@dl-cdn.alpinelinux.org@mirrors.aliyun.com@g" /etc/apk/repositories
RUN apk add --no-cache tzdata unzip libc6-compat curl
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" >> /etc/timezone \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

ENV VERSION=2.3.0
ENV WEBSITE='127.0.0.1'

ENV url=$(curl -s https://api.github.com/repos/cookieY/Yearning/releases |grep browser_download_url |grep "$VERSION"|awk '{print $2}'|sed 's@"@@g')
ENV file=$(echo $url |awk -F "/" '{print $NF}')
RUN cd / && wget $url && unzip $file && rm -rf $file

ADD docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 8000
VOLUME ["/Yearning-go"]


ENTRYPOINT  ["sh", "/docker-entrypoint.sh"]

