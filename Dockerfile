FROM alpine:latest AS builder

WORKDIR /

RUN export URL=https://api.github.com/repos/pymumu/smartdns/releases/latest \
    && export OS="linux" \
    && wget --tries=3 $(curl -s $URL | grep browser_download_url | egrep -o 'http.+\.\w+' | grep -i "$(uname -m)" | grep -m 1 -i "$(echo $OS)") \
    && tar zxvf smartdns.*.tar.gz \
    && mkdir -p /dist/smartdns \
    && mv smartdns/usr/sbin /dist/smartdns \
    && rm -rf smartdns*

# step 2
FROM adguard/adguardhome:latest AS adguardhomeBuilder

# step 3
FROM alpine:latest

LABEL maintainer="Zyao89 <zyao89@gmail.com>"

COPY --from=adguardhomeBuilder /opt/adguardhome/AdGuardHome /opt/adguardhome/AdGuardHome
# Update CA certs
RUN apk --no-cache --update add ca-certificates libcap && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /opt/conf && \
    chmod -R +x /opt/adguardhome
RUN setcap 'cap_net_bind_service=+eip' /opt/adguardhome/AdGuardHome

COPY --from=builder /dist/smartdns /smartdns

ADD files/config.conf /config.conf
ADD files/start.sh /start.sh

WORKDIR /opt/conf/work

RUN mkdir -p /opt/conf/work

RUN chmod +x /start.sh

EXPOSE 53/tcp 53/udp 67/udp 68/udp 80/tcp 443/tcp 443/udp 784/udp 853/tcp 853/udp 8853/udp 5443/tcp 5443/udp 3000/tcp  

VOLUME ["/opt/conf"]

#USER nobody
ENTRYPOINT []

CMD ["/start.sh"]

HEALTHCHECK --interval=5s --timeout=1s CMD ps | grep AdGuardHome | grep -v grep || exit 1
