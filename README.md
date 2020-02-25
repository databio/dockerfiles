# Dockerfiles

This repository contains Dockerfiles for the Sheffield lab. Built images are hosted at [https://hub.docker.com/u/databio](https://hub.docker.com/u/databio). 

## Building images

In this repo is a [Makefile](Makefile) with recipes for building each image.  Type `make IMAGE`, where `IMAGE` is one of the values in the `Dockerfile_IMAGE` (listed below). You can also tab-complete to see which images can be built. You can also re-build any container from scratch (without using caches) by adding '-nocache' to the target name, *e.g.* `make pandoc-nocache`.

## Some useful commands for using docker:

* `docker rm $(docker ps -a -q)`: cleans all stopped containers
* `docker image prune`: removes all dangling images


## Available images
- [pypipe](Dockerfiles/Dockerfile_pypipe)
- [rpipe](Dockerfiles/Dockerfile_rpipe)
