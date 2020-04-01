#!/bin/sh
namespace=$1
if [ -z ${3+x} ]; then 
  echo "Using caches"
  args=""
  image=$2
else
  echo "No caches"
  args="--no-cache "
  n=$2
  image=${2%-nocache}
fi

time docker build ${args}-t ${namespace}/${image} -f Dockerfiles/Dockerfile_${image} . | tee logs/log_$image.txt

if [ -f "versions/${image}.sh" ]; then
  v=`./versions/${image}.sh`
  docker tag ${namespace}/$image ${namespace}/$image:$v
fi
