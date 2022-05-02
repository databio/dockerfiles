# Dockerfiles

This repository contains Dockerfiles for the Sheffield lab. It uses a [Makefile](Makefile) system to make it easy to build these images.

### Pulling images

If you just want to *use* the dockerfiles, you can just pull the images from dockerhub. Built images are (mostly) hosted at [https://hub.docker.com/u/databio](https://hub.docker.com/u/databio). Pull from dockerhub in the usual way:

```
docker pull databio/IMAGE:version
```

## Building images

In this repo is a [Makefile](Makefile), which auto-generates targets for building each image. After cloning the repo, type `make` and use tab completion to see which images can be built. You first must choose the registry and namespace you want to build the image in, then you can tab-complete to see the available images. You then have 3 options:

- Use `make {registry}/{namespace}/{image}/{tag}` to build an image, *e.g.*`make docker.io/databio/pandoc/latest`
- Use `make {registry}/{namespace}/{image}/{tag}-nocache` to re-build from scratch (without using caches). *e.g.* `make docker.io/databio/pandoc/latest-nocache`.

## Adding an image

To add a new image here, just add the Dockerfile file here, named `Dockerfiles/{image}/{tag}`, where `{image}` is the name of the image the dockerfile will build. That's it; the Makefile will automatically generate the targets. This system creates a *hierarchy of folders*, where each image is a folder, and inside the folder is a separate dockerfile for each version of that image. So, to add a new version of an existing tool, just create a new file in that tool's folder. The filename corresponds to the version/tag of the image.

You can also symlink the `latest` to a particular version. In that case, it's times helpful to run the `make` command twice, once for the version and once with `/latest`. This doesn't duplicate the build, since it's cached, but has the affect of adding both a version tag, and a `latest` tag to the built image.

## Version tagging details

We often want to tag an image with the version of the software it contains. In the latest version of this repository, this is now handled by creating separate Dockerfiles, with the filename corresponding to the tag. But in the past, I wanted to do this in an automated way, and have only a single Dockerfile. This way, when you build a new image, it can be automatically tagged with the version it just built. This way, the tags are guaranteed to be kept in sync with the self-reported version. The way I did that is through scripts in the `tags` folder, one for each image that can be tagged. This script will run the `latest` image, which is the one just built, and use it to print out the version of itself, and then pass this to the `docker tag` to auto-tag the image with the correct version of software it contains. The only thing it requires is the code for how the software prints out its version, which is kept in `tags/{image}.sh`. Then, the magic of the tagging happens in `bin/tag.sh`. So, to enable a new Dockerfile to be automatically tagged, just follow the examples in `tags/{image.sh}` and make one for the software in the new image. Tag it using the `make {namespace}/{image}-tag` target. 

However, I've since changed my mind. I don't think this is a good idea because it doesn't give you control to build older versions, and to keep the Dockerfiles separate. I now prefer making it explicit. If you don't care to version control a particular image, just name the Dockerfile `latest` and don't worry about it. But this way, you have the power to version control the Dockerfiles in case it's useful.

## Some useful commands for using docker:

Just for reference:

* `docker rm $(docker ps -a -q)`: cleans all stopped containers
* `docker image prune`: removes all dangling images
