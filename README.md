# Dockerfiles

This repository contains Dockerfiles for the Sheffield lab. It uses a [Makefile](Makefile) system to make it easy to build these images.

### Pulling images

If you just want to *use* the dockerfiles, you can just pull the images from dockerhub. Built images are hosted at [https://hub.docker.com/u/databio](https://hub.docker.com/u/databio). Pull from dockerhub in the usual way:

```
docker pull databio/IMAGE
```

## Building images

In this repo is a [Makefile](Makefile), which auto-generates targets for building each image. After cloning the repo, type `make` and use tab completion to see which images can be built. You first must choose the namespace you want to build the image in, then you can tab-complete to see the available images. You then have 3 options:

- Use `make {namespace}/{image}` to build an image, *e.g.*`make databio/pandoc-nocache`
- Use `make {namespace}/{image}-nocache` to re-build from scratch (without using caches). *e.g.* `make databio/pandoc-nocache`.
- For some images, use `make {namespace}/{image}-tag` to auto-tag the version of the image. This only works if there is an `IMAGE.sh` script in [tags](/tags), which should use the container to return the image of software you installed.

## Adding an image

To add a new image here, just add the a file called `Dockerfiles/Dockerfile_IMAGE`, where IMAGE is the name of the image the dockerfile will build. That's it; the Makefile will automatically generate the targets.

## Version tagging details

We often want to tag an image with the version of the software it contains. It's nice to automate this, so that when you build a new image, it can be automatically tagged with the version it just built. This way, the tags are guaranteed to be kept in sync with the self-reported version.

The way I handle this is through scripts in the `tags` folder, one for each image that can be tagged. This script will run the `latest` image, which is the one just built, and use it to print out the version of itself, and then pass this to the `docker tag` to auto-tag the image with the correct version of software it contains. The only thing it requires is the code for how the software prints out its version, which is kept in `tags/{image}.sh`. Then, the magic of the tagging happens in `bin/tag.sh`.

So, to enable a new Dockerfile to be automatically tagged, just follow the examples in `tags/{image.sh}` and make one for the software in the new image. Tag it using the `make {namespace}/{image}-tag` target.

## Some useful commands for using docker:

Just for reference:

* `docker rm $(docker ps -a -q)`: cleans all stopped containers
* `docker image prune`: removes all dangling images
