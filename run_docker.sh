#!/bin/sh

docker run --network=host -it --gpus all --rm -v `pwd`:/workspace/code mormj/gr-matx-dev bash