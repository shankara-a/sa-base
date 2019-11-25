FROM bitnami/minideb
MAINTAINER Shankara Anand

RUN install_packages build-essential

# Install OpenJDK-8
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    ant \
    wget \
    unzip \
    && apt-get clean;

# Install python3
RUN install_packages python3 python3-pip

# Python dependences
RUN python3 -m pip install --upgrade pip setuptools && pip install pandas matplotlib seaborn

# Add FastQC
RUN wget -O /opt/fastqc_v0.11.8.zip https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.8.zip
RUN unzip /opt/fastqc_v0.11.8.zip -d /opt/
RUN chmod 775 /opt/FastQC/fastqc

# Add to path
RUN ln -s /opt/FastQC/fastqc /bin/fastqc
