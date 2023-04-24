# Usage:
# Build: docker build -t llm-examples .
# Run: docker run -it --rm --privileged --shm-size=64gb --runtime=nvidia --gpus all \
#      --network host -v $(pwd):/home/docker/repo -w /home/docker/repo llm-examples


FROM nvidia/cuda:11.7.1-devel-ubuntu22.04

# Install prerequisite packages
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  curl \
  pip \
  python3 \
  python3-dev \
  sudo \
  unzip \
  vim \
  wget \
  && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python

# Download Ray nightly wheel
RUN wget https://s3-us-west-2.amazonaws.com/ray-wheels/latest/ray-3.0.0.dev0-cp310-cp310-manylinux2014_x86_64.whl

# Install pip packages from requirements.txt
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt
