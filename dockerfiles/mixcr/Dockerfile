FROM ubuntu:18.04
MAINTAINER Shankara Anand

# Install essentials
RUN apt-get update && apt-get install software-properties-common -y &&\
apt-get update &&  apt-get install build-essential git zlib1g-dev \
libgsl-dev libboost-iostreams-dev libncurses5-dev libbz2-dev liblzma-dev curl wget -y

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Install unzip
RUN apt-get update && \
    apt-get install unzip

# ----------------------
# MIXCR
# ----------------------
RUN wget --no-check-certificate -P /opt/ https://github.com/milaboratory/mixcr/releases/download/v3.0.10/mixcr-3.0.10.zip
RUN unzip /opt/mixcr-3.0.10.zip -d /opt
RUN chmod 777 /opt/mixcr-3.0.10/mixcr.jar
RUN rm /opt/mixcr-3.0.10.zip

# Make symlink
RUN echo 'alias mixcr="java -jar /opt/mixcr-3.0.10/mixcr.jar"' >> ~/.bashrc

# ----------------------
# Samtools
# ----------------------
RUN wget --no-check-certificat -P /opt/ https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2
RUN tar -xjf /opt/samtools-1.9.tar.bz2 -C /opt/
RUN rm /opt/samtools-1.9.tar.bz2

# Configure
RUN ./opt/samtools-1.9/configure --prefix=/bin/samtools

# Install
RUN cd /opt/samtools-1.9 && make && make install

# ----------------------
# Picard
# ----------------------
RUN mkdir /opt/picard-tools && \
    wget --no-check-certificate -P /opt/picard-tools/ https://github.com/broadinstitute/picard/releases/download/2.21.1/picard.jar

# Make symlink
RUN echo 'alias picard="java -jar /opt/picard-tools/picard.jar"' >> ~/.bashrc
