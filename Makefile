VERSION ?=$(shell node -p "require('./package.json').version")
MAIN_VERSION = 18.16
RELEASES = patch minor major

BUILD_VERSION = $(MAIN_VERSION)-$(VERSION)

build:
	sed -i '1c FROM node:${MAIN_VERSION}-alpine as builder' Dockerfile
	docker build -t sqlwwx/node:$(BUILD_VERSION)-alpine -t sqlwwx/node:$(MAIN_VERSION)-alpine -t sqlwwx/node:latest .
	docker build -f Dockerfile.git -t sqlwwx/node-git:$(BUILD_VERSION)-alpine -t sqlwwx/node-git:$(MAIN_VERSION)-alpine -t sqlwwx/node-git:latest .
	docker build -f Dockerfile.builder -t sqlwwx/node-builder:$(BUILD_VERSION)-alpine -t sqlwwx/node-builder:$(MAIN_VERSION)-alpine -t sqlwwx/node-builder:latest .

build-base:
	sed -i '1c FROM node:${MAIN_VERSION}-alpine as builder' Dockerfile
	docker build -t sqlwwx/node:$(BUILD_VERSION)-alpine -t sqlwwx/node:$(MAIN_VERSION)-alpine -t sqlwwx/node:latest .

publish:
	docker push sqlwwx/node:$(BUILD_VERSION)-alpine
	docker push sqlwwx/node:$(MAIN_VERSION)-alpine
	docker push sqlwwx/node:latest
	docker push sqlwwx/node-git:$(BUILD_VERSION)-alpine
	docker push sqlwwx/node-git:$(MAIN_VERSION)-alpine
	docker push sqlwwx/node-git:latest
	docker push sqlwwx/node-builder:$(BUILD_VERSION)-alpine
	docker push sqlwwx/node-builder:latest
	docker push sqlwwx/node-builder:$(MAIN_VERSION)-alpine

all: build publish

.PHONY: $(RELEASES)
$(RELEASES):
	npx standard-version --release-as $@
	git push --follow-tags origin master

.PHONY: build publish
