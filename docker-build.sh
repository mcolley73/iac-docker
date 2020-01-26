#!/bin/sh
docker build \
  --build-arg build_time_proxy=$HTTP_PROXY \
  --build-arg no_proxy=$no_proxy \
  --build-arg terraform_path=$1 \
  --no-cache \
  -t mcolley-iac-docker .
