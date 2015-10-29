FROM ubuntu:14.04
MAINTAINER Tapti Palit <tpalit@cs.stonybrook.edu>

RUN apt-get update && apt-get install -y \
	build-essential \
	git \
	nginx

# Increase the open file limit
COPY files/limits.conf.append /tmp/
RUN cat /tmp/limits.conf.append >> /etc/security/limits.conf && rm -f /tmp/limits.conf.append

# Build utilities
COPY files/filegen/ /filegen/
WORKDIR /filegen
RUN make make_zipf gen_fileset

# Update NGINX to server /streaming_server/videos
RUN sed -i 's/\/usr\/share\/nginx\/html/\/streaming_server\/videos/g' /etc/nginx/sites-available/default
#RUN sed -i 's/worker_processes 4;/worker_processes 32/g' /etc/nginx/nginx.conf # @TODO - Fix this!

CMD ["nginx", "-g", "daemon off;"]
