#!/bin/sh
docker build \
  --build-arg build_time_proxy=$HTTP_PROXY \
  --build-arg no_proxy=$no_proxy \
  --no-cache \
  -t mcolley-iac-docker .
