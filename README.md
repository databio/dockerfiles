# Dockerfiles

This repository contains Dockerfiles for the Sheffield lab. It also includes a Makefile that makes it easy to build the images.

## Getting started

Just clone this repository:

```
git clone https://github.com/databio/dockerfiles.git
```

Then, build any containers you want. For example, to build the pandoc container:

```
cd dockerfiles
make TABTAB
```

## Building images

In this repo is a [Makefile](Makefile) with recipes for building each image.  Type `make IMAGE`, where `IMAGE` is one of the values in the `Dockerfile_IMAGE`. You can also tab-complete to see which images can be built. You can also re-build any container from scratch (without using caches) by adding '-nocache' to the target name, *e.g.* `make pandoc-nocache`.



## Some useful commands for using docker:

* `docker rm $(docker ps -a -q)`: cleans all stopped containers
* `docker image prune`: removes all dangling images


## Available images
- [rpipe](Dockerfiles/Dockerfile_rpipe)
