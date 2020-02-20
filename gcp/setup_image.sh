#!/bin/bash
# Ubuntu 18.04

# -----------------------------
# Install utilities, R, Java
# -----------------------------
sudo apt-get update && sudo apt-get install -y software-properties-common

# Add sudo R apt repository
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository "deb http://cran.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran35/"

# Install basic stuff and R
sudo apt-get update && sudo apt-get install -y \
  sudo \
  locales \
  git \
  vim-tiny \
  less \
  wget \
  r-base \
  openjdk-8-jdk \
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
  cmake \
  lbzip2

# Packages fosudo R Apache
sudo apt-get update && sudo apt-get install -y \
  build-essential \
  libboost-filesystem-dev \
  libboost-regex-dev \
  libboost-system-dev \
  apt-utils

# -----------------------------
# Python 3.7
# -----------------------------
sudo apt-get update && sudo apt-get install -y \
      python3.7 \
      python3-pip

# Install python packages
pip3 install pandas \
               numpy \
               tqdm \
               matplotlib \
               seaborn \
               statsmodels \
               argparse \
               torch \
               torchvision \
               port_for

# -----------------------------
# Install R packages
# -----------------------------
sudo R -e "install.packages('qvalue')"
sudo R -e "install.packages('devtools')"
sudo R -e "install.packages('optparse')"
sudo R -e "install.packages('BiocManager')"
sudo R -e "BiocManager::install('edgeR')"
sudo R -e "install.packages('lme4', repos=c('http://lme4.r-forge.r-project.org/repos', getOption('repos')[['CRAN']]))"
sudo R -e "install.packages('lmerTest')"
sudo R -e "install.packages('nlme')"
sudo R -e "BiocManager::install('DESeq2')"
sudo R -e "options(unzip = 'internal')"
sudo R -e "devtools::install_github('dviraran/xCell')"
sudo R -e "install.packages('arm')"
sudo R -e "install.packages('pbkrtest')"
sudo R -e "devtools::install_github('GfellerLab/EPIC', build_vignettes=TRUE)"

# -----------------------------
# Install Parquet C Libs for R
# -----------------------------
# NOTE: this needed to be installed before installing R version of arrow {
sudo apt update
sudo apt install -y -V apt-transport-https gnupg lsb-release wget
sudo wget -O /usr/share/keyrings/apache-arrow-keyring.gpg https://dl.bintray.com/apache/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-keyring.gpg
sudo tee /etc/apt/sources.list.d/apache-arrow.list <<APT_LINE
deb [arch=amd64 signed-by=/usr/share/keyrings/apache-arrow-keyring.gpg] https://dl.bintray.com/apache/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/ $(lsb_release --codename --short) main
deb-src [signed-by=/usr/share/keyrings/apache-arrow-keyring.gpg] https://dl.bintray.com/apache/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/ $(lsb_release --codename --short) main
APT_LINE
sudo apt update
sudo apt install -y -V libarrow-dev # For C++
sudo apt install -y -V libarrow-glib-dev # For GLib (C)
sudo apt install -y -V libarrow-flight-dev # For Flight C++
sudo apt install -y -V libplasma-dev # For Plasma C++
sudo apt install -y -V libplasma-glib-dev # For Plasma GLib (C)
sudo apt install -y -V libgandiva-dev # For Gandiva C++
sudo apt install -y -V libgandiva-glib-dev # For Gandiva GLib (C)
sudo apt install -y -V libparquet-dev # For Apache Parquet C++
sudo apt install -y -V libparquet-glib-dev # For Apache Parquet GLib (C)
# }

# Install arrow
sudo R -e "install.packages('arrow')"

# -----------------------------
# Install CUDA for Tflow/Pytorch
# -----------------------------
# Dependencies
sudo apt-get install -y build-essential \
    dkms \
    freeglut3 \
    freeglut3-dev \
    libxi-dev \
    libxmu-dev

# Install CUDA
sudo wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
sudo apt-get update && install -y cuda

# Add to path
export PATH=$PATH:/usr/local/cuda-10.1/bin
export CUDADIR=/usr/local/cuda-10.1
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.1/lib64

# -----------------------------
# Genomic Tools: samtools, htslib, bedtools
# -----------------------------
wget --no-check-certificate https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
    tar -xf samtools-1.9.tar.bz2 && rm samtools-1.9.tar.bz2 && cd samtools-1.9 && \
    sudo ./configure --enable-libcurl --enable-s3 --enable-plugins --enable-gcs && \
    sudo make && sudo make install && sudo make clean

wget --no-check-certificate https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2 && \
    tar -xf htslib-1.9.tar.bz2 && rm htslib-1.9.tar.bz2 && cd htslib-1.9 && \
    sudo ./configure --enable-libcurl --enable-s3 --enable-plugins --enable-gcs && \
    sudo make && sudo make install && sudo make clean

sudo apt-get update && sudo apt-get install -y bedtools

# -----------------------------
# Setup Docker
# -----------------------------
sudo apt-get update && sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# -----------------------------
# Swap Space
# -----------------------------
sudo fallocate -l4G /swapfile
sudo chmod 700 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab

# -----------------------------
# Helpers
# -----------------------------
echo "
rmate ()
{
    export RMATE_PORT=$(python3 -c 'import port_for;print(port_for.select_random())');
    echo 'Enter the following into the SSH menu:';
    echo '-R $RMATE_PORT:localhost:52779';
    unset -f rmate
}

jp ()
{
    export JUPYTER_PORT=$(python3 -c 'import port_for;print(port_for.select_random())');
    echo 'Enter the following command in the ~C ssh menu:';
    echo '-L $JUPYTER_PORT:localhost:$JUPYTER_PORT';
    jupyter notebook --no-browser --ip=127.0.0.1 --port=$JUPYTER_PORT
}
" >> ~/.bashrc
