#!/bin/sh

# This script just builds a dockerfile

registry=$1
namespace=$2
image=$3
tag=$4

echo "Building image..."
echo "Registry: ${registry}"
echo "Namespace: ${namespace}"
echo "Image: ${image}"
echo "Tag: ${tag}"

time docker build -t ${namespace}/${image}:${tag} \
  -f Dockerfiles/${image}/${tag} . | tee logs/log_$image_$tag.txt
