# eDNA-contained

A qiime2 based eDNA anaylsis pipeline running in a docker container based on Ubuntu 20.04.

## Introduction  
This anaylsis pipeline will process a folder of paired-end fastq files.

## Running from flask
```
sudo docker build -f Dockerfile . -t dwheelerau/edna:edna
docker images
### copy IMAGEID ###
sudo docker run -p 80:5000 --rm IMAGEID
```

## Docker hub
```
sudo docker push dwheelerau/edna:edna
```

## Install
sudo docker build -f Dockerfile . -t dwheelerau/edna:ubuntu2004
```
sudo docker run -it -d -v /media/dwheeler/spinner/Linux_space/projects/bioinformatics/edna-contained:/project 446ddaf10ed0 /bin/bash
docker ps -a
sudo docker exec -it elated_meitner /bin/bash
```
