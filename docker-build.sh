#!/bin/sh

# We will need a path to terraform from the local build system
if [ $# -eq 0 ]
then
  echo "Missing argument!"
  echo "  Usage: ./docker-build.sh [/full/path/to/terraform]"
  exit 1
fi

# We copy the terraform binary into a local ./tmp path and remove it later
[ -d ./tmp ] || mkdir ./tmp
cp $1 ./tmp
terraform_build_arg=`find ./tmp/ter*`

# Execute our docker build, passing it the location of our terraform binary
docker build \
  --build-arg build_time_proxy=$HTTP_PROXY \
  --build-arg no_proxy=$no_proxy \
  --build-arg terraform_path=$terraform_build_arg \
  --no-cache \
  -t iac-docker .

rm -rf ./tmp
