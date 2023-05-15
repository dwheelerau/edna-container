#To build this file:
#sudo docker build -f Dockerfile . -t dwheelerau/marsupial:ubuntu2004

#To run this, mounting your current host directory in the container directory,
# at /project, and excute the check_installtion script which is in your current
# working direcotry run:
#sudo docker run --gpus all -it -v `pwd`:/project dwheelerau/marsupial:ubuntu2004 /bin/bash -c "cd /project && python /build/marsupial/prediction_batch.py -i /build/marsupial/data -m /build/marsupial/weights/marsupial_72s.pt -o processed_images"

#To push to docker hub:
#sudo docker push dwheelerau/marsupial:ubuntu2004

# Pull base image.
FROM nvidia/cuda:11.2.0-cudnn8-devel-ubuntu20.04
MAINTAINER Dave Wheeler NSWDPI

# Set up ubuntu dependencies
RUN apt-get update -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata vim wget git build-essential git curl libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 && \
  rm -rf /var/lib/apt/lists/*

###### 
# Make the dir everything will go in
WORKDIR /build

# Intall anaconda 3.9
ENV PATH="/build/miniconda3/bin:${PATH}"
ARG PATH="/build/miniconda3/bin:${PATH}"
RUN curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_22.11.1-1-Linux-x86_64.sh &&\
	mkdir /build/.conda && \
	bash miniconda.sh -b -p /build/miniconda3 &&\
	rm -rf miniconda.sh

RUN conda --version

# Install camera traps and dependencies
#ENV PYTHONPATH="$PYTHONPATH:/build/cameratraps:/build/ai4eutils:/build/yolov5"
#ARG PYTHONPATH="$PYTHONPATH:/build/cameratraps:/build/ai4eutils:/build/yolov5"

# clone the repo
RUN git clone https://github.com/dwheelerau/marsupial # comment
#RUN git clone https://github.com/Microsoft/cameratraps

#RUN git clone https://github.com/ultralytics/yolov5/ && \
#  cd yolov5 && git checkout c23a441c9df7ca9b1f275e8c8719c949269160d1

# install dependencies
RUN python -m pip install --upgrade pip
RUN pip --version
RUN pip install gradio torch pandas numpy torchvision wandb jupyterlab kaggle opencv-python seaborn scipy
#RUN conda install Pillow=9.1.0 nb_conda_kernels ipykernel tqdm jsonpickle humanfriendly numpy matplotlib opencv requests pandas seaborn>=0.11.0 PyYAML>=5.3.1 pytorch::pytorch=1.10.1 pytorch::torchvision=0.11.2 conda-forge::cudatoolkit=11.2 conda-forge::cudnn=8.1 -c conda-forge

CMD /bin/bash
