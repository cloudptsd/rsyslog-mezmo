ARG         ALPINE_TAG=3.18.4
FROM        alpine:${ALPINE_TAG}
LABEL       maintainer="CloudPTSD"
ARG         RSYSLOG_VERSION=8.2306.0-r2
RUN         apk add -U --upgrade --no-cache \
              ca-certificates \
              rsyslog-tls=${RSYSLOG_VERSION}
RUN         adduser -s /bin/ash -D rsyslog rsyslog \
            && echo "rsyslog ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN         wget https://assets.logdna.com/rootca/ld-root-ca.crt -O /usr/share/ca-certificates/ld-root-ca.crt
VOLUME      /config /logs /work
ENTRYPOINT  ["/start.sh"]
COPY        rsyslog.conf /etc/rsyslog.conf
COPY        rsyslog.d/*.conf /etc/rsyslog.d/
WORKDIR     /
COPY        start.sh ./
RUN         chmod +x start.sh
RUN         chown -R rsyslog:rsyslog start.sh
