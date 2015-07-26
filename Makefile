default: build

build:
	docker build -t gostatic/openresty .

shell:
	docker run -h "gostatic-openresty" -i -t --rm --name gostatic-openresty-shell gostatic/openresty bash
