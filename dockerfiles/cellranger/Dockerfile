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
# Install bcl2fastq
# ------------------------------------
COPY bcl2fastq2-v2.20.0.422-Linux-x86_64.rpm /opt/
RUN apt-get install alien -y
RUN alien /opt/bcl2fastq2-v2.20.0.422-Linux-x86_64.rpm
RUN mv bcl2fastq2_0v2.20.0.422-2_amd64.deb /opt/
RUN dpkg -i /opt/bcl2fastq2_0v2.20.0.422-2_amd64.deb

# ------------------------------------
# Install Cellranger 3
# ------------------------------------
COPY cellranger-3.1.0 /opt/cellranger-3.1.0/
RUN echo 'export PATH=/opt/cellranger-3.1.0:$PATH' >> ~/.bashrc
