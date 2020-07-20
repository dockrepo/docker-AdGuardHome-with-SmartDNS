#!/bin/sh

# open smartdns
OPEN_SMARTDNS=${OPEN_SMARTDNS:=false}

if [ $OPEN_SMARTDNS = 'true' ]; then
    if [ ! -f /opt/conf/smartdns.conf ]; then
        cp -u /config.conf /opt/conf/smartdns.conf
    fi
    exec /smartdns/sbin/smartdns -f -x -c /opt/conf/smartdns.conf &
fi

# adguardhome
exec /opt/adguardhome/AdGuardHome -h 0.0.0.0 -c /opt/conf/AdGuardHome.yaml -w /opt/conf/work --no-check-update
