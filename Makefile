# https://gist.github.com/mpneuried/0594963ad38e68917ef189b4e6a269db
cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

dpl ?= deploy.env
include $(dpl)
export $(shell sed 's/=.*//' $(dpl))

APP_NAME=$(shell jq -r .name package.json)
VERSION=$(shell jq -r .version package.json)

# https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds
export DOCKER_BUILDKIT=1

.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


.DEFAULT_GOAL := help

# DOCKER TASKS

# *** run ***
up: build stop run ## Run container on port configured in `config.env` (Alias to run)

# Build the container
build: ## Build the release and develoment container. The development
	docker build -t $(APP_NAME) .

run: ## Run container on port configured in `config.env`
	docker run -i -t -d --env-file=./config.env -p=$(PORT):$(PORT) --name=$(APP_NAME) $(APP_NAME)

stop: ## Stop and remove a running container
	docker container stop $(APP_NAME) && docker rm -f $(APP_NAME) || true

clean: ## Clean the generated/compiles files
	echo "nothing clean ..."

version: ## Output the current version
	@echo $(VERSION)

# *** test ***
test: clean stop run
	docker exec -it $(APP_NAME) npm test

# *** image tagging ***
tag: tag-latest tag-version ## Generate container tags for the `{version}` ans `latest` tags

tag-latest: ## Generate container `{version}` tag
	@echo 'create tag latest'
	docker tag $(APP_NAME) $(DOCKER_REPO)/$(APP_NAME):latest

tag-version: ## Generate container `latest` tag
	@echo 'create tag $(VERSION)'
	docker tag $(APP_NAME) $(DOCKER_REPO)/$(APP_NAME):$(VERSION)

# *** release image ***
release: build publish ## Make a release by building and publishing the `{version}` ans `latest` tagged containers to Docker HUB

publish: repo-login publish-latest publish-version ## Publish the `{version}` ans `latest` tagged containers to Docker Hub

publish-latest: tag-latest ## Publish the `latest` taged container to Docker Hub
	@echo 'publish latest to $(DOCKER_REPO)'
	docker push $(DOCKER_REPO)/$(APP_NAME):latest

publish-version: tag-version ## Publish the `{version}` taged container to Docker Hub
	@echo 'publish $(VERSION) to $(DOCKER_REPO)'
	docker push $(DOCKER_REPO)/$(APP_NAME):$(VERSION)

######## HELPERS #########

# generate script to login to aws docker repo

# login to Docker Hub
repo-login: ## Auto login to Docker Hub container registry
	cat ~/.password.txt | docker login --username $(DOCKER_USER) --password-stdin https://$(DOCKER_REPO)
