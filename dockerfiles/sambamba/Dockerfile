FROM ubuntu:18.04
MAINTAINER Shankara Anand

# Essentials
RUN apt-get update && apt-get install software-properties-common -y &&\
apt-get update &&  apt-get install build-essential git zlib1g-dev \
libgsl-dev libboost-iostreams-dev -y

RUN apt-get install -y wget gzip

# Copy source
RUN mkdir /opt/sambamba
RUN wget -O /opt/sambamba/sambamba-0.7.0-linux-static.gz https://github.com/biod/sambamba/releases/download/v0.7.0/sambamba-0.7.0-linux-static.gz
RUN gunzip /opt/sambamba/sambamba-0.7.0-linux-static.gz

# Executable
RUN chmod a+x /opt/sambamba/sambamba-0.7.0-linux-static

# Add to path
RUN ln -s /opt/sambamba/sambamba-0.7.0-linux-static /bin/sambamba
