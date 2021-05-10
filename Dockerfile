FROM debian:stable

ENV PID_DIR /tmp/pidDir
ENV GROK_ARCH="grok_exporter-1.0.0.RC5.linux-amd64"
ENV GROK_VERSION="v1.0.0.RC5"

USER root


RUN apt-get update -qqy \
    && apt-get upgrade -qqy \
    && apt-get install --no-install-recommends -qqy \
       wget unzip ca-certificates \
    && update-ca-certificates \
    && wget https://github.com/fstab/grok_exporter/releases/download/$GROK_VERSION/$GROK_ARCH.zip \
    && unzip $GROK_ARCH.zip \
    && mv $GROK_ARCH /grok \
    && rm $GROK_ARCH.zip \
    && apt-get --autoremove purge -qqy \
       wget unzip ca-certificates \
    && rm -fr /var/lib/apt/lists/*


RUN mkdir -p /etc/grok_exporter
RUN ln -sf /etc/grok_exporter/config.yml /grok/

RUN apt-get update
