# This Makefile makes it convenient to build included images
# Dockerfile must be named: Dockerfiles/Dockerfile_IMAGE
# Built image will be named: namespace/IMAGE

SHELL:=/bin/bash

# Choose docker namespaces for images to build
# You can choose which namespace to use by specifying which target to build
# These are actually registry/namespace combinations
namespace=docker.io/databio
namespace2=ghcr.io/databio

# Construct an array of images for Dockerfiles
IMAGES := $(shell ls Dockerfiles/Dockerfile_* | sed 's/Dockerfiles\/Dockerfile_//g')
IMAGES_WITH_VERSIONS := $(shell ls Dockerfiles/*/* | sed 's/Dockerfiles\///g')

# Now build the actual targets:
#  IMAGES: will be the generic docker build
#  NOCACHE: will add a -nocache flag to build
#  TAG: will tag the image. Requires instructions shell script.
IMAGES1=$(addprefix $(namespace)/, $(IMAGES_WITH_VERSIONS))
NOCACHE_TARGETS1=$(addsuffix -nocache, $(IMAGES1))
TAG_TARGETS1=$(addsuffix -tag, $(IMAGES1))

IMAGES2=$(addprefix $(namespace2)/, $(IMAGES_WITH_VERSIONS))
NOCACHE_TARGETS2=$(addsuffix -nocache, $(IMAGES2))
TAG_TARGETS2=$(addsuffix -tag, $(IMAGES2))



# Most of the heavy lifting happens in the /bin/build... scripts. 
# These targets below will automatically construct a different
# Makefile target for each image, in each namespace, with 
# regular build, nocache, and tag target for each. 

$(IMAGES1):
	./bin/build.sh $(subst /, ,$@)

$(NOCACHE_TARGETS1):
	./bin/build_nocache.sh $(subst /, ,$@)

$(TAG_TARGETS1):
	./bin/tag.sh $(subst /, ,$@)

$(IMAGES2):
	./bin/build.sh $(subst /, ,$@)

$(NOCACHE_TARGETS2):
	./bin/build_nocache.sh $(subst /, ,$@)

$(TAG_TARGETS2):
	./bin/tag.sh $(subst /, ,$@)

