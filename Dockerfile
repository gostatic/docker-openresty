FROM ubuntu:14.04
MAINTAINER Marc Qualie <marc@marcqualie.com>

RUN apt-get update -qqy \
 && apt-get upgrade -y \
 && apt-get autoremove -y \
 && apt-get clean -y

ENV OPENRESTY_VERSION=1.7.10.2
ADD ngx_openresty-$OPENRESTY_VERSION.tar.gz /root/
RUN cd /root/ngx_openresty-$OPENRESTY_VERSION \
 && apt-get install -y libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make build-essential \
 && ./configure \
    --prefix=/opt/openresty \
    --with-luajit --with-luajit-xcflags=-DLUAJIT_ENABLE_LUA52COMPAT \
    --without-http_fastcgi_module \
    --without-http_uwsgi_module \
    --without-http_scgi_module \
 && make \
 && make install \
 && rm -rf /root/ngx_openresty-$OPENRESTY_VERSION \
 && ln -sf /opt/openresty/nginx/sbin/nginx /usr/local/bin/nginx \
 && ln -sf /usr/local/bin/nginx /usr/local/bin/openresty \
 && ln -sf /opt/openresty/bin/resty /usr/local/bin/resty \
 && touch /opt/openresty/nginx/logs/access.json \
 && touch /opt/openresty/nginx/logs/error.log \
 && apt-get purge -y libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make build-essential \
 && apt-get autoremove -y \
 && apt-get clean -y

EXPOSE 80
