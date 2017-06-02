default: build

build:
	docker build -t gostatic/openresty:latest .
	docker build -t gostatic/openresty:v1.11.2.3 .

shell:
	docker run -h "gostatic-openresty" -i -t --rm --name gostatic-openresty-shell gostatic/openresty bash
