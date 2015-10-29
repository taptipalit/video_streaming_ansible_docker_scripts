# Container description
FROM ubuntu:14.04
MAINTAINER Tapti Palit <tpalit@cs.stonybrook.edu>

RUN apt-get update && apt-get install -y \
	build-essential \
	git \
	libssl-dev

# Build utilities
COPY files/videoperf/ /videoperf/
WORKDIR /videoperf
RUN ./configure
RUN make

CMD bash
