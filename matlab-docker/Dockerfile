FROM ubuntu:16.04
LABEL maintainer="NAME <email@email.com>"

#USER root
RUN echo 'Acquire::http::Proxy "http://apt-cache-server:3142";' > /etc/apt/apt.conf.d/02proxy
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    libpng12-dev libfreetype6-dev \
    libblas-dev liblapack-dev gfortran build-essential xorg \
&& rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/MATLAB/R2017b/bin:${PATH}"
ENTRYPOINT ["matlab", "-logfile /var/log/matlab/matlab.log"]
CMD ["-h"]
