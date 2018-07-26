FROM centos:7

# Setup docker package repo
RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install packages
RUN INSTALL_PKGS="wget git yum-utils device-mapper-persistent-data lvm2 docker-ce" \
  && yum -y update && yum -y install $INSTALL_PKGS && yum clean all -y

# Install pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py \
  && python get-pip.py --user

ENV PATH=$PATH:/root/.local/bin

# Download AWS client
RUN pip install awscli --upgrade --user

# Download s2i
RUN wget https://github.com/openshift/source-to-image/releases/download/v1.1.10/source-to-image-v1.1.10-27f0729d-linux-amd64.tar.gz \
 && tar xvzf source-to-image-v1.1.10-27f0729d-linux-amd64.tar.gz \
 && mv s2i /usr/local/bin \
 && mv sti /usr/local/bin \
 && rm source-to-image-v1.1.10-27f0729d-linux-amd64.tar.gz

# Install docker dependencies
