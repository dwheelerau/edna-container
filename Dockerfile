#To build this file:
#sudo docker build -f Dockerfile . -t dwheelerau/edna:ubuntu2004

#To run this, mounting your current host directory in the container directory,
# at /project, and excute the check_installtion script which is in your current
# working direcotry run:
#sudo docker run -d -it -v `pwd`:/project dwheelerau/edna:ubuntu2004 /bin/bash

#To push to docker hub:
#sudo docker push dwheelerau/edna:ubuntu2004

# Pull base image.
FROM ubuntu:20.04
MAINTAINER Dave Wheeler NSWDPI

# Set up ubuntu dependencies
RUN apt-get update -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata vim wget git nano build-essential curl libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 ca-certificates pandoc && \
  rm -rf /var/lib/apt/lists/*

###### 
# Make the dir everything will go in
WORKDIR /build

# Intall anaconda 3.9
ENV PATH="/build/miniconda3/bin:${PATH}"
ARG PATH="/build/miniconda3/bin:${PATH}"
RUN curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_22.11.1-1-Linux-x86_64.sh && \
	mkdir /build/.conda && \
	bash miniconda.sh -b -p /build/miniconda3 && \
	rm -rf miniconda.sh

RUN conda --version

# clone the repo
RUN git clone https://dpidave@bitbucket.org/dpi_data_analytics/snakemake-qiime-edna.git


# install dependencies
RUN conda install -n base -c conda-forge mamba
RUN mamba init
RUN mamba env create -f snakemake-qiime-edna/env/qiime2-2023.2-snakemake-py38-linux-conda.yml
