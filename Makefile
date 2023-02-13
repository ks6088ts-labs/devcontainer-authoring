SOURCE_FILES ?= $(shell find . -type d \( -name node_modules -o -name .git \) -prune -o -type f -name '*.md' -print)

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.DEFAULT_GOAL := help

.PHONY: install-deps-dev
install-deps-dev: ## install dependencies for development
	yarn

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
	docker build -f ./Dockerfile -t authoring .

.PHONY: docker-run
docker-run: ## run docker container
	docker run --rm -it -v ${PWD}:/workspace -w /workspace authoring /bin/bash
