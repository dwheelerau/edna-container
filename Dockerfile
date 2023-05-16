#To build this file:
#sudo docker build -f Dockerfile . -t dwheelerau/edna:ubuntu2004

#To run this, mounting your current host directory in the container directory,
# at /project, and excute the check_installtion script which is in your current
# working direcotry run:
#sudo docker run -d -it -v `pwd`:/project dwheelerau/edna:ubuntu2004 /bin/bash

#To push to docker hub:
#sudo docker push dwheelerau/edna:ubuntu2004

# Pull base image.
#FROM ubuntu:20.04
FROM continuumio/miniconda3
MAINTAINER Dave Wheeler NSWDPI

# Set up ubuntu dependencies
RUN apt-get update -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata vim wget zip git nano build-essential curl libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 ca-certificates pandoc && \
  rm -rf /var/lib/apt/lists/*

###### 
# Make the dir everything will go in
#WORKDIR /build
WORKDIR /home/docker_conda_template

# copy all the local files into the image
COPY . .

# make boot script runable
RUN chmod +x boot.sh

# clone the repo
RUN git clone https://dpidave@bitbucket.org/dpi_data_analytics/snakemake-qiime-edna.git

RUN conda env create -f snakemake-qiime-edna/env/qiime2-2023.2-snakemake-py38-linux-conda.yml

RUN echo "source activate snakemake-qiime2" >> ~/.bashrc
ENV PATH /opt/conda/envs/snakemake-qiime2/bin:$PATH

EXPOSE 5000
RUN chmod +x app.py
ENTRYPOINT ["./app.py"]
