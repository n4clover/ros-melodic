#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
cd $DIR

SHARD_DIR=`pwd`/..
CATKIN_WS="/root/catkin_ws"

xhost +local:root

docker run --net=host\
  --name ros_client \
  --rm \
  --privileged \
  -it \
  --gpus all \
  --device=/dev/dri:/dev/dri \
  --device=/dev/input:/dev/input \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --volume="$SHARD_DIR:$CATKIN_WS:rw" \
  --shm-size 1G \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -w "$CATKIN_WS/src" \
  n4clover/ros:ros-melodic-base \
  /bin/bash
