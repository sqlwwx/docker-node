VERSION ?=$(shell node -p "require('./package.json').version")
MAIN_VERSION = 16
RELEASES = patch minor major

build:
	sed -i '1c FROM node:${MAIN_VERSION}-alpine as builder' Dockerfile
	docker build -t sqlwwx/node:$(VERSION) -t sqlwwx/node:$(MAIN_VERSION) -t sqlwwx/node:latest .
	docker build -f Dockerfile.git -t sqlwwx/node-git:$(VERSION) -t sqlwwx/node-git:$(MAIN_VERSION) -t sqlwwx/node-git:latest .
	docker build -f Dockerfile.builder -t sqlwwx/node-builder:$(VERSION) -t sqlwwx/node-builder:$(MAIN_VERSION) -t sqlwwx/node-builder:latest .

publish:
	docker push sqlwwx/node:$(VERSION)
	docker push sqlwwx/node:$(MAIN_VERSION)
	docker push sqlwwx/node:latest
	docker push sqlwwx/node-git:$(VERSION)
	docker push sqlwwx/node-git:$(MAIN_VERSION)
	docker push sqlwwx/node-git:latest
	docker push sqlwwx/node-builder:$(VERSION)
	docker push sqlwwx/node-builder:latest
	docker push sqlwwx/node-builder:$(MAIN_VERSION)

all: build publish

.PHONY: $(RELEASES)
$(RELEASES):
	npx standard-version --release-as $@
	git push --follow-tags origin master

.PHONY: build publish
