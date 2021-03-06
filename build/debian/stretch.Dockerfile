FROM debian:stretch

ENV RUNLEVEL 1
ENV DEBIAN_FRONTEND noninteractive

RUN apt autoremove && \ 
    apt autoclean && \
    apt clean

RUN apt-get update -qq && \
    apt-get install -y -f \
    apt-transport-https \
    default-dbus-session-bus \
    ca-certificates \
    lsb-release \
    curl \
    gnupg2

RUN mkdir -p /opt/gluu-installer

COPY . /opt/gluu-installer

WORKDIR /opt/gluu-installer

RUN chmod +x install-gluu.sh && \
    chmod +x scripts/post-install.sh && \
    chmod +x deploy.sh

RUN ./install-gluu.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ./scripts/post-install.sh

CMD [ "bash" ]
