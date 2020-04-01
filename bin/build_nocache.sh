namespace=$1
image=${2%-nocache}

time docker build --nocache -t ${namespace}/${image} -f Dockerfiles/Dockerfile_${image} . | tee logs/log_$image.txt

if [ -f "versions/${image}.sh" ]; then
  v=`./versions/${image}.sh`
  docker tag ${namespace}/$image ${namespace}/$image:$v
fi
