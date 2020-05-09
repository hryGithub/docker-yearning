FROM alpine:latest

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
RUN echo "http://mirrors.ustc.edu.cn/alpine/v3.3/main/" > /etc/apk/repositories
RUN apk add --no-cache tzdata unzip
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" >> /etc/timezone \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

ENV VERSION=2.2.1
RUN cd / && wget https://github.com/cookieY/Yearning/releases/download/v$VERSION/Yearning-$VERSION.linux-amd64.zip \
    && unzip Yearning-$VERSION.linux-amd64.zip && mv Yearning-go opt && rm -rf Yearning-$VERSION.linux-amd64.zip
EXPOSE 8000
WORKDIR /opt

ENTRYPOINT  ["/opt/Yearning"]

CMD ["-m", "-s"]
