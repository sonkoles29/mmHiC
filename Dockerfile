FROM docker.io/ubuntu:bionic
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /home
COPY . /home/install/

# Update and create base image
RUN apt-get update -y &&\
    apt-get install apt-utils -y &&\
    apt-get install -y wget &&\
    apt-get install -y unzip &&\
    apt-get install -y bzip2
# Install Anaconda
SHELL ["/bin/bash", "-c"]
RUN wget -q https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh &&\
    bash Anaconda3-2019.03-Linux-x86_64.sh -b -p /root/anaconda3
ENV PATH="/root/anaconda3/bin:${PATH}"
RUN conda update -y conda &&\
    conda update -y conda-build

# Install cooltools environment
RUN conda env create -f /home/install/cooltools.yml 
# Install git and gcc
RUN apt-get install -y git &&\
    apt-get install -y gcc g++
# Install bioframe, cooltools and pairlib
RUN source activate cooltools &&\
    pip install git+git://github.com/mirnylab/bioframe@master &&\
    pip install git+git://github.com/mirnylab/cooltools@master &&\
    pip install git+git://github.com/mirnylab/pairlib@master

    #&&\
    #source ~/.bashrc &&\
    #conda init bash &&\
    #conda activate cooltools
# Install bioframe, cooltools and pairlib

#RUN 