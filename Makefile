# login first
# # docker loging, or,
# #
# # docker login -p FpXM6Qy9vVL5kPeoefzxwA-oaYb-Wpej2iXTwV7UHYs -e unused -u unused docker-registry-default.openkbs.org

# oc process -f ./files/deployments/template.yml -v API_NAME=$(REGISTRY_IMAGE) > template.active
#
# to run:
# make <verb> APP_VERSION=<> APPLICATION_NAME=<>
# example:
#   make push version=1.0.1

ORGANIZATION=$(shell echo $${ORGANIZATION:-openkbs})
PROJECT=$(shell echo $${PROJECT:-dev})
APPLICATION_NAME=$(shell echo $${PWD\#\#*/})

APP_VERSION=$(shell echo $${APP_VERSION:-latest})
# APP_VERSION=$(shell echo $${APP_VERSION:-1.0.0})

imageTag=$(ORGANIZATION)/$(APPLICATION_NAME)

## Docker Registry (Private Server)
REGISTRY_HOST=$(shell echo $${REGISTRY_HOST:-registry01.openkbs.org:5000})
REGISTRY_IMAGE=$(REGISTRY_HOST)/$(ORGANIZATION)/$(APPLICATION_NAME)

#VERSION?="$(APP_VERSION)-$$(date +%Y%m%d)"
VERSION?="$(APP_VERSION)"

# The name of the container (default is current directory name)
## DOCKER := $(shell echo $${PWD\#\#*/})
DOCKER=$(APPLICATION_NAME)
DOCKER_REPO=$(REGISTRY_HOST)/$(PROJECT)
# APPLICATION_NAME ~= $(DOCKER_REPO)/$(DOCKER):$(VERSION)


## -- To Check syntax:
#  cat -e -t -v Makefile

#VOLUME_MAP := "-v $${PWD}/json:/json -v $${PWD}/data:/data"
VOLUME_MAP := 

# { no, on-failure, unless-stopped, always }
RESTART_OPTION := always

SHA := $(shell git describe --match=NeVeRmAtCh --always --abbrev=40 --dirty=*)

.PHONY: clean rmi build push create pull up down run stop exec

clean:
	docker rm -f $(APPLICATION_NAME)

rmi:
	docker rmi -f $$(docker images -f dangling=true -q)

build:
	docker build \
	-t $(imageTag):latest .

push: build
	#docker tag $(imageTag):$(VERSION) $(REGISTRY_IMAGE):$(VERSION)
	docker tag $(imageTag):latest $(REGISTRY_IMAGE):latest
	#docker push $(REGISTRY_IMAGE):$(VERSION)
	docker push $(REGISTRY_IMAGE):latest

save:
	@if [ ! "$(IMAGE_EXPORT_PATH)" = "" ]; then \
		mkdir -p $(IMAGE_EXPORT_PATH); \
		docker save $(REGISTRY_IMAGE):latest | gzip > $(IMAGE_EXPORT_PATH)/$(APPLICATION_NAME).tar.gz; \
	fi
	
pull:
	docker pull $(REGISTRY_IMAGE):latest

up: 
	docker-compose up -d

down:
	docker-compose down

run: build
	docker run --name=$(APPLICATION_NAME) --restart=$(RESTART_OPTION) $(VOLUME_MAP) $(imageTag):latest

stop:
	docker stop --name=$(APPLICATION_NAME)

exec: up
	docker-compose exec $(APPLICATION_NAME) /bin/bash
