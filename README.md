# GoStatic Openresty

This is the base configuration for our hosted CDN. We use this minimal starting point to expand where needed for different services.



## Example Usage

The following two lines are all that is needed to get up and running with openresty on Docker.

``` dockerfile
FROM gostatic/openresty:latest
ADD nginx.conf /opt/openresty/nginx/conf/nginx.conf
```



## Supervisor Configuration

All of our services are ran via Supervisor. The following config is enough to get started

``` ini
# /etc/supervisor.conf
[supervisord]
nodaemon=true

[include]
files = /etc/supervisor/conf.d/*.conf
```

``` ini
# /etc/supervisor/conf.d/nginx.conf
[program:openresty]
command=/opt/openresty/nginx/sbin/nginx -c conf/nginx.conf
autorestart=true
priority=1
```
