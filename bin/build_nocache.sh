#!/bin/sh

# This script just builds a dockerfile with -nocache

namespace=$1
image=${2%-nocache}

echo "Building image..."
echo "Namespace: ${namespace}"
echo "Image: ${image}"

time docker build --no-cache -t ${namespace}/${image} \
  -f Dockerfiles/Dockerfile_${image} . | tee logs/log_$image.txt

if [ -f "versions/${image}.sh" ]; then
  v=`./versions/${image}.sh`
  docker tag ${namespace}/$image ${namespace}/$image:$v
fi
