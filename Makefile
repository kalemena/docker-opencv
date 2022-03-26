
VERSION := latest
VERSION_GIT := 4.0.1
IMAGE_FROM := ubuntu:22.04

all: build start

build:
	@echo "+++ Building docker image +++"
	docker pull $(IMAGE_FROM)
	docker build --build-arg IMAGE_FROM=$(IMAGE_FROM) --build-arg VERSION=$(VERSION) -t kalemena/opencv:$(VERSION) .

build-git:
	@echo "+++ Building docker image +++"
	docker build --build-arg VERSION=$(VERSION_GIT) -f Dockerfile.source -t kalemena/opencv:$(VERSION_GIT) .

start:
	@echo "+++ Environment starting ... +++"
	/bin/bash ./run.sh
	@echo "+++ Environment started +++"

tests-redeye:
	/bin/bash ./build-tests.sh