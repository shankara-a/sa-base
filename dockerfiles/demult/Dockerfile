FROM ubuntu:18.04
MAINTAINER shankara.k.anand@gmail.com
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y software-properties-common

# Add R apt repository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository "deb http://cran.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran35/"

# Install basic stuff and R
RUN apt-get update && apt-get install -y \
    sudo \
    locales \
    git \
    vim-tiny \
    less \
    wget \
    r-base \
    r-base-dev \
    r-recommended \
    fonts-texgyre \
    texinfo \
    locales \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libssl-dev \
    cmake

# Install Python3
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
                 argparse

# Install Vireo
RUN pip3 install -U git+https://github.com/single-cell-genetics/vireo

# Install FreeBayes
RUN git clone --recursive git://github.com/ekg/freebayes.git \
  && cd freebayes && make
ENV PATH="/freebayes/bin/:${PATH}"

# Install cellSNP
RUN pip3 install Cython
RUN pip3 install pysam
RUN pip3 install -U git+https://github.com/single-cell-genetics/cellSNP

# Install Rust
RUN apt-get update && apt-get install -y curl
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install minimap2
RUN curl -L https://github.com/lh3/minimap2/releases/download/v2.17/minimap2-2.17_x64-linux.tar.bz2 | tar -jxvf -
ENV PATH="/minimap2-2.17_x64-linux/:${PATH}"

# Install Samtools
RUN wget --no-check-certificate https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
    tar -xf samtools-1.9.tar.bz2 && rm samtools-1.9.tar.bz2 && cd samtools-1.9 && \
    ./configure --enable-libcurl --enable-s3 --enable-plugins --enable-gcs && \
    make && make install && make clean

# Install Vartix
RUN wget https://github.com/10XGenomics/vartrix/releases/download/v1.1.8/vartrix_linux -P /opt/ && \
  chmod u+x /opt/vartrix_linux && ln /opt/vartrix_linux /usr/bin/vartrix

# Install SouporCell
RUN git clone https://github.com/wheaton5/souporcell.git && \
  cd souporcell/souporcell && cargo build --release && cd ../troublet && \
  cargo build --release
ENV PATH="/souporcell/souporcell/target/release/:${PATH}"
ENV PATH="/souporcell/troublet/target/release/:${PATH}"

# Required python dependencies for Souporcell consensus
RUN pip3 install pystan pyvcf
