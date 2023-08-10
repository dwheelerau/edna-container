#!/bin/bash
echo "clone the GUI repo used by docker"
git clone https://github.com/dwheelerau/edna-container.git

echo "changing the port number to $1"
cd edna-container
sed -i "s/5000/$1/" app.py
grep "port" app.py
chmod +x app.py

echo "clone the main run scripts and env file"
git clone https://dpidave@bitbucket.org/dpi_data_analytics/snakemake-qiime-edna.git

echo "install the conda env"
cd snakemake-qiime-edna

conda env create -f env/qiime2-2023.2-snakemake-py38-linux-conda.yml
