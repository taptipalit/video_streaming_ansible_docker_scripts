# Container description
FROM ubuntu:14.04
MAINTAINER Tapti Palit <tpalit@cs.stonybrook.edu>

ENV ssh_key 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+wQsUJy+fC2Gh8M59sdbu7gJAE+I9m/p/ndtiQTHPBSrfb0WnDYDXOcX3MpTzD87F/48iyvYZrxnm+xPiNoa8H/v3AKL8+G5X057+LkUuAQugAvPNlSJDH2rqWjHJdGoIijN7OtoWn+ugpYv+xxT64bvrrLUF+fzSzYoqTzOV6NwgBgrP221+HSt5nJvQw0fr/SOJlga8nI7/V9WXl3YAIOhpdkEtPEuendE5zfEtHJrQcGTBOsnpHcRLcX6f+9JdJhi8RU6HfU2bdfsw9nJO3do5A8jnyGLex0DhFa0dsXD36LbPqGbCiJJ5YQXxJ9B9bvuN47hmV8jFWPPVtuDd tpalit@stpauligirl'

RUN apt-get update && apt-get install -y openssh-server
RUN apt-get install -y build-essential
RUN apt-get install -y git
RUN apt-get install -y vim

RUN mkdir /var/run/sshd
RUN mkdir /benchmarking
RUN chmod a+rwx /benchmarking

RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN mkdir -p /root/.ssh
RUN echo ${ssh_key}  > /root/.ssh/authorized_keys
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
EXPOSE 80
CMD ["/usr/sbin/sshd", "-D"]

