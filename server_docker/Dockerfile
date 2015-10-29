# Container description
FROM ubuntu:14.04
MAINTAINER Tapti Palit <tpalit@cs.stonybrook.edu>

# Install software
RUN apt-get update && RUN apt-get install -y \
	build-essential \
	git \
	nginx

# Create the mount-point for the shared directory, with the host
RUN mkdir /benchmarking
RUN chmod a+rwx /benchmarking

# Create another directory to store the source code
RUN mkdir /streaming_source
RUN chmod a+rwx /streaming_source

# Increase the open file limit
COPY files/limits.conf.append /tmp/
RUN cat /tmp/limits.conf.append >> /etc/security/limits.conf && rm -f /tmp/limits.conf.append

# Clone the file generation repo and build it
RUN git clone https://github.com/taptipalit/fileset_log_generator.git /streaming_source/filegen
RUN make -C /streaming_source/filegen make_zipf

# Update NGINX directory to point to /videos. The videos will be generated via the Ansible script
RUN sed -i 's/\/usr\/share\/nginx\/html/\/benchmarking\/videos/g' /etc/nginx/sites-available/default
#RUN sed -i 's/worker_processes 4;/worker_processes 32/g' /etc/nginx/nginx.conf # @TODO - FIx this!

RUN service nginx start
CMD bash
