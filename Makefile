SOURCE_FILES ?= $(shell find . -type d \( -name dist -o -name node_modules \) -prune -o -type f -name '*.md' -print)

GIT_REVISION ?= $(shell git rev-parse --short HEAD)
GIT_TAG ?= $(shell git describe --tags --abbrev=0 | sed -e s/v//g)

DOCKER_IMAGE_NAME ?= devcontainer-authoring

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.DEFAULT_GOAL := help

.PHONY: info
info: ## show info
	echo "GIT_REVISION: $(GIT_REVISION), GIT_TAG: $(GIT_TAG)"

.PHONY: install-deps-dev
install-deps-dev: ## install dependencies for development
	yarn install --frozen-lockfile && yarn cache clean

.PHONY: fix
fix: ## fix
	yarn run textlint --fix $(SOURCE_FILES)

.PHONY: lint
lint: ## run lint
	yarn run textlint $(SOURCE_FILES)

.PHONY: ci-test
ci-test: install-deps-dev lint ## run CI test

.PHONY: docker-build
docker-build: ## build docker image
	docker build -f ./Dockerfile -t $(DOCKER_IMAGE_NAME) .

.PHONY: docker-run
docker-run: ## run docker container
	docker run --rm -it -v $(PWD):/workspace -w /workspace $(DOCKER_IMAGE_NAME) /bin/bash
