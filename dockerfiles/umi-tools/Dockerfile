FROM ubuntu:18.04
MAINTAINER Shankara Anand

# Install essentials
RUN apt-get update && apt-get install -y build-essential software-properties-common

# Install other packages
RUN apt-get update && apt-get install -y \
  git \
  zlib1g-dev \
  libgsl-dev \
  libncurses5-dev \
  libbz2-dev \
  liblzma-dev \
  wget \
  gzip \
  zip \
  libbz2-dev

# ------------------------------------
# Install Python3
# ------------------------------------
RUN apt-get update && apt-get install -y \
        python3.7 \
        python3-pip

# Install python packages
RUN pip3 install pandas \
                 numpy \
                 tqdm \
                 matplotlib \
                 seaborn \
                 statsmodels \
                 argparse \
                 umi_tools
