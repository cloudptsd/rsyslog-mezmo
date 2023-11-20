#!/bin/ash

if [ ! -z "$INGESTION_KEY" ]; then
    sed -i "s/REPLACE_WITH_KEY/$INGESTION_KEY/g" /etc/rsyslog.d/mezmo.conf
    echo "Installed INGESTION_KEY"
else
    echo "INGESTION_KEY environment variable not set!"
    exit 1
fi

if [ -f "/config/rsyslog.conf" ]; then
    echo "Using rsyslog.conf from config directory"
    cp /config/rsyslog.conf /etc/rsyslog.conf
else
    echo "Copying rsyslog.conf to config directory"
    cp /etc/rsyslog.conf /config/rsyslog.conf
fi

if [ -d "/config/rsyslog.d" ]; then
    echo "Using rsyslog.d from config directory"
    cp /config/rsyslog.d/ /etc/rsyslog.d
else
    echo "Copying rsyslog.d to config directory"
    cp -r /etc/rsyslog.d /config
fi

rsyslogd -n
