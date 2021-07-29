# This Makefile provides convenience targets to build the included docker images
# Dockerfile is named: Dockerfiles/Dockerfile_IMAGE
# image is named: namespace/IMAGE

SHELL:=/bin/bash

# choose docker namespace for images to build
namespace=databio
namespace2=ghcr.io_databio

# Construct an array of images (and nocache targets) with available Dockerfiles
IMAGES := $(shell ls Dockerfiles/Dockerfile_* | sed 's/Dockerfiles\/Dockerfile_//g')
NOCACHE_TARGETS=$(addsuffix -nocache, $(IMAGES))
TAG_TARGETS=$(addsuffix -tag, $(IMAGES))

IMAGES1=$(addprefix $(namespace)_, $(IMAGES))
IMAGES2=$(addprefix $(namespace2)_, $(IMAGES))

# These Makefile targets create generic recipes following the build_image
# functions above for each entry in the IMAGES list. This will automatically
# create a target for each Dockerfile, and a second target for each Dockerfile
# with "-nocache" added. if you call that nocache recipe, it will call the
# build_image_nocache function instead, which just adds the --nocache to the
# docker build call.

$(IMAGES):
	./bin/build.sh $(namespace) $@

$(IMAGES1):
	./bin/build.sh $(namespace) $@

$(NOCACHE_TARGETS):
	./bin/build_nocache.sh $(namespace) $@

$(TAG_TARGETS):
	./bin/tag.sh $(namespace) $@

$(IMAGES2):
	./bin/build.sh $(subst "_" , "/" , $(namespace2)) $@
