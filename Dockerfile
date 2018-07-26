FROM centos:7

RUN INSTALL_PKGS="wget git" \
  && yum -y update && yum -y install $INSTALL_PKGS && yum clean all -y

# Download go
RUN wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz \
  && tar xvzf go1.10.3.linux-amd64.tar.gz \
  && mv go /usr/local \
  && rm go1.10.3.linux-amd64.tar.gz

ENV GOROOT /usr/local/go
ENV GOPATH /var/golang
ENV PATH=$PATH:$GOPATH/bin:$GOROOT/bin

# Download ECR credential helper
RUN go get -u github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login
RUN mkdir -p /root/.docker
COPY config.json /root/.docker/config.json

# Download s2i
RUN wget https://github.com/openshift/source-to-image/releases/download/v1.1.10/source-to-image-v1.1.10-27f0729d-linux-amd64.tar.gz \
 && tar xvzf source-to-image-v1.1.10-27f0729d-linux-amd64.tar.gz \
 && mv s2i /usr/local/bin \
 && mv sti /usr/local/bin \
 && rm source-to-image-v1.1.10-27f0729d-linux-amd64.tar.gz
