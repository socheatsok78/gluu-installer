FROM ubuntu:trusty

RUN apt-get update -q && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    lsb-release \
    curl \
    gnupg2

RUN mkdir -p /opt/gluu-installer

COPY . /opt/gluu-installer

WORKDIR /opt/gluu-installer

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/socheatsok78/gluu-installer/master/setup.sh)"

CMD [ "bash" ]
