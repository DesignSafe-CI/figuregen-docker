######################################################
#
# FigureGen image
# Tag: stevemock/figuregen-docker
#
# This is FigureGen image on Ubuntu 12.04
#
# To run your own input, mount your data to the /data volume and
# specify the traditional invocation command
#
# docker run -it --rm -v `pwd`:/data stevemock/figuregen-docker /bin/sh -c 'FigureGen.out -I MyInp.inp'
#
# The data will appear in your current directory at the end of the run.
#
######################################################

FROM ubuntu:12.04
MAINTAINER Stephen Mock <mock@tacc.utexas.edu>
RUN apt-get -y update
RUN apt-get -y install build-essential gfortran libhdf5-serial-dev libnetcdf-dev libgmt4 libgmt-dev gmt ghostscript && \
    groupadd --gid 816877 G-816877 && useradd --uid 458981 --create-home --shell /bin/bash --user-group --groups G-816877 ubuntu && chown ubuntu:G-816877 /home/ubuntu && \
    cd /home/ubuntu && \
    mkdir FigureGen

COPY FigureGenZ.F90 /home/ubuntu/FigureGen
RUN cd /home/ubuntu/FigureGen && \
    gfortran -ffree-line-length-none FigureGenZ.F90 -DNETCDF -I/usr/include -L/usr/lib -lnetcdf -lnetcdff -o FigureGen.out 

RUN mkdir /data && chown ubuntu:G-816877 /data
WORKDIR /data
USER ubuntu
ENV PATH $PATH:/home/ubuntu/FigureGen
VOLUME ["/data"]

