FROM ubuntu:14.04
MAINTAINER Marc Qualie <marc@marcqualie.com>

RUN apt-get update -qqy && apt-get upgrade -y
RUN apt-get install -y libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make build-essential wget

EXPOSE 80

ENV OPENRESTY_VERSION=1.7.10.2
ADD ngx_openresty-$OPENRESTY_VERSION.tar.gz /root/
RUN cd /root/ngx_openresty-$OPENRESTY_VERSION \
 && ./configure \
    --prefix=/opt/openresty \
    --with-luajit --with-luajit-xcflags=-DLUAJIT_ENABLE_LUA52COMPAT \
    --with-pcre-jit --with-ipv6 \
    --without-http_fastcgi_module \
    --without-http_uwsgi_module \
    --without-http_scgi_module \
 && make \
 && make install \
 && rm -rf ngx_openresty-$OPENRESTY_VERSION \
 && ln -sf /opt/openresty/nginx/sbin/nginx /usr/local/bin/nginx \
 && ln -sf /usr/local/bin/nginx /usr/local/bin/openresty
