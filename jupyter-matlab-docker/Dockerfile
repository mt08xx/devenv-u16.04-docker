FROM jupyter/scipy-notebook

LABEL maintainer="NAME <email@email.com>"

USER root
RUN echo 'Acquire::http::Proxy "http://apt-cache-server:3142";' > /etc/apt/apt.conf.d/02proxy
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    libpng12-dev libfreetype6-dev \
    libblas-dev liblapack-dev gfortran build-essential xorg \
&& rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/conda/bin:/opt/MATLAB/R2017b/bin:${PATH}"
#RUN cd /opt/MATLAB/R2017b/extern/engines/python && python setup.py install
#RUN pip install matlab_kernel
#RUN pip install imatlab && python -mimatlab install
