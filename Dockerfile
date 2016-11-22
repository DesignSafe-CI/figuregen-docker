######################################################
#
# FigureGen image
# Tag: stevemock/docker-opensees
#
# This is FigureGen image on Ubuntu 12.04
#
# docker run -it --rm stevemock/docker-opensees
#
# To run your own input, mount your data to the /data volume and
# specify the traditional invocation command
#
# docker run -it --rm -v `pwd`:/data stevemock/docker-opensees /bin/sh -c 'OpenSees < /data/myinput.tcl'
#
# The data will appear in your current directory at the end of the run.
#
######################################################

FROM ubuntu:12.04
MAINTAINER Stephen Mock <mock@tacc.utexas.edu>
RUN apt-get -y update
RUN apt-get -y install build-essential gfortran libhdf5-serial-dev libnetcdf-dev libgmt4 libgmt-dev gmt ghostscript && \
    useradd --create-home ubuntu && \
    cd /home/ubuntu && \
    mkdir FigureGen

COPY FigureGenZ.F90 /home/ubuntu/FigureGen
#COPY input.tar.gz /home/ubuntu/FigureGen
RUN cd /home/ubuntu/FigureGen && \
#    tar -xvf input.tar.gz &&\
    gfortran -ffree-line-length-none FigureGenZ.F90 -DNETCDF -I/usr/include -L/usr/lib -lnetcdf -lnetcdff -o FigureGen.out 
#    cp FigureGen.out input &&\
#    cd input &&\
#    ./FigureGen.out -I FG51.inp

WORKDIR /data
ENV PATH $PATH:/home/ubuntu/FigureGen
VOLUME ["/data"]

