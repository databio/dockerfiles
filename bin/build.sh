#!/bin/sh
namespace=$1
image=$2

time docker build -t ${namespace}/${image} -f Dockerfiles/Dockerfile_${image} . | tee logs/log_$image.txt
