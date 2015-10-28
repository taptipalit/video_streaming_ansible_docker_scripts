# Container description
FROM ubuntu:14.04
MAINTAINER Tapti Palit <tpalit@cs.stonybrook.edu>

# Install software
RUN apt-get update 
RUN apt-get install -y build-essential
RUN apt-get install -y git

# Create the mount-point for the shared directory 
RUN mkdir /benchmarking
RUN chmod a+rwx /benchmarking

# Create another directory to store the source code
RUN mkdir /streaming_source
RUN chmod a+rwx /streaming_source

# Clone the Video Httperf client
RUN git clone https://github.com/taptipalit/videoperf.git /streaming_source/httperf
RUN /streaming_source/httperf/configure
RUN make -C /streaming_source/httperf

