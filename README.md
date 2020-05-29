# AdGuardHome, with SmartDNS

[Docker] AdGuardHome with SmartDNS

[![Docker Build Status](https://img.shields.io/docker/build/zyao89/adguardhome-with-smartdns.svg)](https://hub.docker.com/r/zyao89/adguardhome-with-smartdns) [![Docker Automated build](https://img.shields.io/docker/automated/zyao89/adguardhome-with-smartdns.svg)](https://hub.docker.com/r/zyao89/adguardhome-with-smartdns) [![Docker Stars](https://img.shields.io/docker/stars/zyao89/adguardhome-with-smartdns.svg)](https://hub.docker.com/r/zyao89/adguardhome-with-smartdns) [![Docker Pulls](https://img.shields.io/docker/pulls/zyao89/adguardhome-with-smartdns.svg)](https://hub.docker.com/r/zyao89/adguardhome-with-smartdns)

This Dockerfile build an image for [AdGuardHome](https://hub.docker.com/r/adguard/adguardhome) with SmartDNS.

## Quick Start

```shell
docker run -d --name adguardhome-with-smartdns \
-p 53:53/tcp -p 53:53/udp -p 67:67/udp -p 68:68/tcp -p 68:68/udp -p 80:80/tcp -p 443:443/tcp -p 853:853/tcp -p 3000:3000/tcp \
-v /my/own/confdir:/opt/conf \
zyao89/adguardhome-with-smartdns
```

## Use SmartDNS

set `upstream DNS servers`:

```
127.0.0.1:5353
```

## Thanks

This docker image is based on [AdGuardHome](https://hub.docker.com/r/adguard/adguardhome) and SmartDNS's docker image.
