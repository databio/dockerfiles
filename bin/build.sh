#!/bin/sh

# This script just builds a dockerfile

namespace=$1
image=$2

echo "Building image..."
echo "Namespace: ${namespace}"
echo "Image: ${image}"

time docker build -t ${namespace}/${image} \
  -f Dockerfiles/Dockerfile_${image} . | tee logs/log_$image.txt
