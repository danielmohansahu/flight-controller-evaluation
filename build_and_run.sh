#!/usr/bin/bash
set -eo pipefail

# get path to here
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# build and tag docker image
DOCKERIMAGE="flight-controller-evaluation"
docker build -t $DOCKERIMAGE -f $SCRIPTPATH/Dockerfile .

# drop into a container
docker run \
    -it \
    --rm \
    --gpus=all \
    --net=host \
    --privileged \
    -e DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -e XAUTHORITY=/tmp/.docker.xauth \
    -v /tmp/.docker.xauth:/tmp/.docker.xauth \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /etc/localtime:/etc/localtime:ro \
    -v $SCRIPTPATH:/workspace \
    -w /workspace \
    $DOCKERIMAGE:latest \
    byobu

