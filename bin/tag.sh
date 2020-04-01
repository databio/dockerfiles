#!/bin/sh

namespace=$1
image=${2%-tag}

if [ -f "versions/${image}.sh" ]; then
  v=`./versions/${image}.sh`
  echo "Setting tag: ${namespace}/$image:$v"
  docker tag ${namespace}/$image ${namespace}/$image:$v
fi
