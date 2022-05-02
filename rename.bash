#!/bin/bash

for f in `ls Dockerfiles/Dockerfile_*`; do
	echo "$f "
	x=`echo "$f" | sed 's/Dockerfiles\/Dockerfile_//g'`
	mkdir Dockerfiles/$x
	mv $f Dockerfiles/$x/latest
done