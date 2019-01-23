
VERSION := 4.0.1

all: build start

build:
	@echo "+++ Building docker image +++"
	docker build --build-arg VERSION=$(VERSION) -t kalemena/opencv:$(VERSION) .

start:
	@echo "+++ Environment starting ... +++"
	/bin/bash ./run.sh
	@echo "+++ Environment started +++"

tests-redeye:
	/bin/bash ./build-tests.sh