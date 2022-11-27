#!/usr/bin/env make

.PHONY: build
build:
	docker build . -t artis3n/docker-opensuse-tumbleweed-ansible:$${TAG:-test}

.PHONY: test
test: build
	dgoss run -it --rm --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro artis3n/docker-opensuse-tumbleweed-ansible:$${TAG:-test}
	# CI=true make size

.PHONY: test-edit
test-edit: build
	dgoss edit -it --rm --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro artis3n/docker-opensuse-tumbleweed-ansible:$${TAG:-test}

.PHONY: size
size: build
	if [ ! -f /usr/local/bin/dive ]; then brew install dive; fi;
	dive artis3n/docker-opensuse-tumbleweed-ansible:$${TAG:-test}

.PHONY: lint
lint:
	hadolint --ignore DL3007 --ignore DL3037 --ignore DL3013 --ignore DL3035 Dockerfile

.PHONY: run
run: build
	docker run -id --rm --name runner --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro artis3n/docker-opensuse-tumbleweed-ansible:$${TAG:-test}
	-docker exec -it runner /bin/sh
	docker stop runner
