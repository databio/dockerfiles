# Dockerfiles

This repository contains Dockerfiles for the Sheffield lab. 

## Pulling images

Built images are hosted at [https://hub.docker.com/u/databio](https://hub.docker.com/u/databio). Pull from dockerhub in the usual way:

```
docker pull databio/IMAGE
```


## Building images

In this repo is a [Makefile](Makefile) with recipes for building each image. After cloning the repo, type `make IMAGE`, where `IMAGE` is one of the values in `Dockerfile_IMAGE` (listed below). You can also tab-complete to see which images can be built. 

There are 3 types of Makefile target you can build for each dockerfile:

### image (vanilla)

This just runs `docker build`.

### image-nocache

Re-build any container from scratch (without using caches) by appending '-nocache' to the target name, *e.g.* `make pandoc-nocache`.

### image-tag

For some images, you can auto-tag the version by appending `-tag`, such as `make IMAGE-tag`. This only works if there is an `IMAGE.sh` script in [tags](/tags), which should use the container to return the image of software you installed.






## Some useful commands for using docker:

* `docker rm $(docker ps -a -q)`: cleans all stopped containers
* `docker image prune`: removes all dangling images


## Available images
- [pypipe](Dockerfiles/Dockerfile_pypipe)
- [rpipe](Dockerfiles/Dockerfile_rpipe)
