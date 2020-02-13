FROM ubuntu:18.10
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

# Packages for Apache
RUN apt-get update && apt-get install -y \
    build-essential \
    libboost-filesystem-dev \
    libboost-regex-dev \
    libboost-system-dev \
    apt-utils

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

# R packages
RUN R -e "install.packages('devtools')"
RUN R -e "install.packages('optparse')"
RUN R -e "install.packages('BiocManager')"
RUN R -e "BiocManager::install('edgeR')"
RUN R -e "install.packages('lme4', repos=c('http://lme4.r-forge.r-project.org/repos', getOption('repos')[['CRAN']]))"
RUN R -e "install.packages('lmerTest')"
RUN R -e "install.packages('nlme')"
RUN R -e "BiocManager::install('DESeq2')"
RUN R -e "options(unzip = 'internal')"
RUN R -e "devtools::install_github('dviraran/xCell')"
RUN R -e "install.packages('arm')"
RUN R -e "install.packages('pbkrtest')"
RUN R -e "devtools::install_github('GfellerLab/EPIC', build_vignettes=TRUE)"
RUN R -e "install.packages('argparse')"
