FROM debian:buster

RUN apt-get update -q -y && \
    apt-get install -q -y apt-transport-https ca-certificates gnupg && \
    apt-get -q clean && rm -rf /var/lib/apt/lists/*
RUN apt-key adv --fetch-keys https://packagecloud.io/varnishcache/varnish65/gpgkey && \
    echo "deb https://packagecloud.io/varnishcache/varnish65/debian/ buster main" > /etc/apt/sources.list.d/varnish.list && \
    apt-get update -q -y && \
    apt-get install -q -y varnish && \
    apt-get -q clean && rm -rf /var/lib/apt/lists/*

VOLUME /etc/varnish
EXPOSE  80 6082
ENTRYPOINT ["/usr/sbin/varnishd", "-F", "-a", ":80", "-T", ":6082", "-f", "/etc/varnish/default.vcl"]
CMD ["-s", "malloc,1G"]
