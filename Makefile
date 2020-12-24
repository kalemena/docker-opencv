
VERSION := latest
VERSION_GIT := 4.0.1

all: build start

build:
	@echo "+++ Building docker image +++"
	docker pull ubuntu:20.04
	docker build --build-arg VERSION=$(VERSION) -t kalemena/opencv:$(VERSION) .

build-git:
	@echo "+++ Building docker image +++"
	docker build --build-arg VERSION=$(VERSION_GIT) -f Dockerfile.source -t kalemena/opencv:$(VERSION_GIT) .

start:
	@echo "+++ Environment starting ... +++"
	/bin/bash ./run.sh
	@echo "+++ Environment started +++"

tests-redeye:
	/bin/bash ./build-tests.sh