#!/bin/sh

working_dir=`PWD`

if [ $# -lt "1" ]
then
  echo "Wrong arguments."
elif [ $# -eq "2" ]
then
  working_dir=$2
fi

home_dir=$1
echo "home: $home_dir"
echo "work: $working_dir"

docker run -it --rm \
  -v $working_dir:/workspace \
  -v $home_dir:/root \
  --net host \
  iac-docker:latest /bin/ash
