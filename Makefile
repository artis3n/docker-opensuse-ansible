#!/usr/bin/env make

.PHONY: install
install:
	if [ ! -f /usr/local/bin/goss ]; then curl -fsSL https://goss.rocks/install | sh; fi

.PHONY: lint
lint:
	cd leap && make lint
	cd tumbleweed && make lint

.PHONY: size
size: build
	cd leap && make size
	cd tumbleweed && make size

.PHONY: test
test: build
	cd leap && make test
	cd tumbleweed && make test

.PHONY: test-edit
test-edit: build
	cd leap && make test-edit
	cd tumbleweed && make test-edit

.PHONY: build
build:
	cd leap && make build
	cd tumbleweed && make build
