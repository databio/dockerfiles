#!/bin/sh

# This script doesn't build -- it tags a dockerfile.
namespace=$1
image=${2%-tag}

echo "Tagging image..."
echo "Namespace: ${namespace}"
echo "Image: ${image}"

if [ -f "tags/${image}.sh" ]; then
  v=`./tags/${image}.sh`
  echo "Setting tag: ${namespace}/$image:$v"
  docker tag ${namespace}/$image ${namespace}/$image:$v
else
	echo "Tag instruction must exist at 'tags/${image}.sh'"
fi
