FROM alpine:latest AS builder

WORKDIR /

RUN wget https://github.com/pymumu/smartdns/releases/download/Release31/smartdns.1.2020.05.04-0005.x86-linux-all.tar.gz \
    && tar zxvf smartdns.*.tar.gz \
    && mkdir -p /dist/smartdns \
    && mv smartdns/usr/sbin /dist/smartdns \
    && rm -rf smartdns*

FROM adguard/adguardhome:latest
LABEL maintainer="Zyao89 <zyao89@gmail.com>"

COPY --from=builder /dist/smartdns /smartdns

ADD files/config.conf /config.conf
ADD files/start.sh /start.sh

WORKDIR /opt/conf/work

RUN mkdir -p /opt/conf/work

RUN chmod +x /start.sh

VOLUME ["/opt/conf"]

#USER nobody
ENTRYPOINT []

CMD ["/start.sh"]

HEALTHCHECK --interval=5s --timeout=1s CMD ps | grep smartdns | grep -v grep || exit 1
