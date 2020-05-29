#!/bin/sh
if [ ! -f /opt/conf/smartdns.conf ]; then
    cp -u /config.conf /opt/conf/smartdns.conf
fi
exec /smartdns/sbin/smartdns -f -x -c /opt/conf/smartdns.conf &

# adguardhome
exec /opt/adguardhome/AdGuardHome -h 0.0.0.0 -c /opt/conf/AdGuardHome.yaml -w /opt/conf/work --no-check-update
