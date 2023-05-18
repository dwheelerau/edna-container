# eDNA-contained

## Introduction
A Docker image containing a eDNA/amplicon pipeline based on
[QIIME2](https://qiime2.org/). The pipeline is controlled via flask GUI that runs
in the users browser.   

**The advantages of the pipeline are:**  
- simple to setup and run using point and click with a browser based GUI
- should run on any machine where [Docker-desktop](https://www.docker.com/products/docker-desktop/) can be installed
- adaptable to any primer combination or taxonomic database
- snakemake is used to confirm successful completion of each stage of the pipeline
- species summary tables with counts are created, including the ASV sequence for manual confirmation of the taxonomic classification
- rarefaction and taxonomic barplots are generated that can be viewed using the QIIME viewer (drag and drop)
- A PDF report is generated containing QC plots and important information about the ASV generation so that QC parameters can be optimised 

The pipeline can also be used without Docker as described at this [repo](https://bitbucket.org/dpi_data_analytics/snakemake-qiime-edna/src/master/).  

## Running the image in a container on Windows
Ensure that the Docker-desktop app is installed on your windows computer. A 
complete guide for installing and running Docker images in general can be found
at [here](https://github.com/dwheelerau/docker-guide).  

1. Start by opening the Docker-desktop app.  
2. Open a command line terminal using the start menu

xxxx

3. Type the following in the terminal window to obtain a copy of the image.  
```
docker pull dwheelerau/edna:edna
```
4. The image should appear in your Docker desktop app under the 'images' section. 
Using the mouse copy the letter/number code reported in the xxx column, this
is the image id (IMAGEID) that will be used in the next command. or comyp desktop

4. Type the following command in the terminal window replacing "IMAGEID"
with the code you copied above.
```
docker run -p 80:5000 --rm IMAGEID
```

Open a internet browser (recommend chrome) and enter the following IP address:  
```
www.xxxx.com\80
```

Either search using the Docker-desktop GUI for `dwheelerau/edna` or pull
the image from a terminal window using (make sure Docker-desktop is running):  
```
sudo docker push dwheelerau/edna:edna
```
To run the image 



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
