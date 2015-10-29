# Container description
FROM ubuntu:14.04
MAINTAINER Tapti Palit <tpalit@cs.stonybrook.edu>

RUN apt-get update && apt-get install -y \
	build-essential \
	git \
	libssl-dev

# Build dummynet for bandwidth limiting
RUN git clone https://github.com/luigirizzo/dummynet /dummynet

WORKDIR /dummynet
RUN make
RUN make install
RUN insmod kipfw-mod/ipfw_mod.ko
RUN cp cp ipfw/ipfw /usr/bin/

# Copy the bandwidth limiting script

COPY bw_setup.sh /

# Build utilities
COPY files/videoperf/ /videoperf/
WORKDIR /videoperf
RUN ./configure
RUN make

CMD bash
