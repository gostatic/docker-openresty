FROM alpine:3.2
MAINTAINER Marc Qualie <marc@marcqualie.com>

ENV OPENRESTY_VERSION=1.7.10.2
ENV PACKAGES="readline-dev ncurses-dev pcre-dev openssl-dev perl make build-base supervisor"
ADD ngx_openresty-$OPENRESTY_VERSION.tar.gz /root/
RUN apk update \
 && apk add $PACKAGES \
 && cd /root/ngx_openresty-$OPENRESTY_VERSION \
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
 && touch /opt/openresty/nginx/logs/access.json \
 && touch /opt/openresty/nginx/logs/error.log \
 && mkdir -p /var/log/supervisor \
 && mkdir -p /etc/supervisor/conf.d \
 && apk del $PACKAGES

EXPOSE 80
CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf"]
