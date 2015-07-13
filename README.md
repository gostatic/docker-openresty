# GoStatic Openresty

This is the base configuration for our hosted CDN. Not much use on it's own but it's a great, minimal starting point to start with your OpenResty application.


## Example Usage

``` dockerfile
FROM gostatic/openresty

ADD nginx.conf /opt/openresty/nginx/conf/nginx.conf
```


## Credits

Original inspiration from [3scale/openresty](https://github.com/3scale/docker-openresty).
