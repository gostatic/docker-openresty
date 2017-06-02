FROM ubuntu:16.04
MAINTAINER Marc Qualie <marc@marcqualie.com>

ENV OPENRESTY_VERSION=1.11.2.3
ADD openresty-$OPENRESTY_VERSION.tar.gz /root/
RUN cd /root/openresty-$OPENRESTY_VERSION \
 && apt-get -qq update -y \
 && apt-get -qq upgrade -y \
 && apt-get install -y libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make build-essential supervisor \
 && ./configure \
    --prefix=/opt/openresty \
    --with-luajit --with-luajit-xcflags=-DLUAJIT_ENABLE_LUA52COMPAT \
    --without-http_fastcgi_module \
    --without-http_uwsgi_module \
    --without-http_scgi_module \
 && make \
 && make install \
 && rm -rf /root/openresty-$OPENRESTY_VERSION \
 && ln -sf /opt/openresty/nginx/sbin/nginx /usr/local/bin/nginx \
 && ln -sf /usr/local/bin/nginx /usr/local/bin/openresty \
 && ln -sf /opt/openresty/bin/resty /usr/local/bin/resty \
 && touch /opt/openresty/nginx/logs/access.json \
 && touch /opt/openresty/nginx/logs/error.log \
 && mkdir -p /var/log/supervisor \
 && mkdir -p /etc/supervisor/conf.d \
 && apt-get purge -y libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make build-essential \
 && apt-get autoremove -y \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf"]
