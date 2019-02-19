FROM debian:stretch

RUN apt-get update -q -y && \
    apt-get install -q -y apt-transport-https ca-certificates gnupg
RUN apt-key adv --fetch-keys https://packagecloud.io/varnishcache/varnish60lts/gpgkey && \
    echo "deb https://packagecloud.io/varnishcache/varnish60lts/debian/ stretch main" > /etc/apt/sources.list.d/varnish.list && \
    apt-get update -q -y && \
    apt-get install -q -y varnish && \
    apt-get -q clean && rm -rf /var/lib/apt/lists/*

VOLUME /etc/varnish
EXPOSE  80 6082
ENTRYPOINT exec /usr/sbin/varnishd -F -a :80 -T :6082 -f /etc/varnish/default.vcl -s malloc,1G
