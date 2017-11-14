FROM docker:git

# Install CA certificates
RUN apk update \
 && apk add ca-certificates wget \
 && update-ca-certificates

# Download s2i
RUN wget https://github.com/openshift/source-to-image/releases/download/v1.1.8/source-to-image-v1.1.8-e3140d01-linux-amd64.tar.gz \
 && tar xvzf source-to-image-v1.1.8-e3140d01-linux-amd64.tar.gz \
 && mv s2i /usr/local/bin \
 && mv sti /usr/local/bin \
 && rm source-to-image-v1.1.8-e3140d01-linux-amd64.tar.gz
