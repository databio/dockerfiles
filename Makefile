# This Makefile just makes it convenient to build the included docker images
# Dockerfile is named: Dockerfile_IMAGE
# image is named: namespace/IMAGE

SHELL:=/bin/bash
namespace=databio  # choose docker namespace for images to build

# Construct an array of images (and nocache targets) with available Dockerfiles
IMAGES := $(shell ls Dockerfiles/Dockerfile_* | sed 's/Dockerfiles\/Dockerfile_//g')
NOCACHE_TARGETS=$(addsuffix -nocache, $(IMAGES))
.PHONY: $(IMAGES)  

# This macro creates the docker build command for a given image
define build_image
	time docker build -t $(namespace)/$(1) -f Dockerfiles/Dockerfile_$(1) . | tee logs/log_$(1).txt
endef

# This macro creats docker build commands for the 'nocache' images
# It looks ugly but it works beautifully. It assigns the make variable to a
# bash variable, using bash variable replacement to create a new variable that
# lacks the '-nocache' flag, and then uses that new variable (as a bash
# variable). Wow, what a pain, but I could not figure out how to get string
# replacements working directly on make variables...
define build_image_nocache
	longtgt=$(1); tgt=$${longtgt/-nocache/}; time docker build --no-cache -t nsheff/$$tgt -f Dockerfiles/Dockerfile_$$tgt . | tee logs/log_$$tgt.txt
endef

# These Makefile targets create generic recipes following the build_image
# functions above for each entry in the IMAGES list. This will automatically
# create a target for each Dockerfile, and a second target for each Dockerfile
# with "-nocache" added. if you call that nocache recipe, it will call the
# build_image_nocache function instead, which just adds the --nocache to the
# docker build call.
$(IMAGES):
	$(call build_image,$@)

$(NOCACHE_TARGETS):
	$(call build_image_nocache,$@)
