FROM ubuntu:18.04
MAINTAINER Shankara Anand

# Essentials
RUN apt-get update && apt-get install software-properties-common -y &&\
apt-get update &&  apt-get install build-essential git zlib1g-dev \
libgsl-dev libboost-iostreams-dev -y

# Copy source
COPY sambamba-0.7.0-linux-static /opt/sambamba/

# Executable
RUN chmod a+x /opt/sambamba/sambamba-0.7.0-linux-static

# Add to path
RUN ln -s /opt/sambamba/sambamba-0.7.0-linux-static /bin/sambamba

# Test
RUN sambamba
