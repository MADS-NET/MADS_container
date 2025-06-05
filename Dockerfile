FROM ubuntu:24.04
LABEL org.opencontainers.image.authors="paolo.bosetti@unitn.it"
ARG DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC
ARG TARGETPLATFORM
ARG MADS_VERSION=1.2.6
RUN apt-get update && \
    apt-get install -y  wget && \
    apt-get upgrade -y && \
    apt-get clean && \
    useradd -m -s /bin/bash mads && \
    mkdir -p /home/mads/etc

RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
    wget https://github.com/pbosetti/MADS/releases/download/v${MADS_VERSION}/mads-${MADS_VERSION}-Linux-aarch64.deb && \
      dpkg -i mads-${MADS_VERSION}-Linux-aarch64.deb && \
      rm mads-${MADS_VERSION}-Linux-aarch64.deb ;\
    elif [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
    wget https://github.com/pbosetti/MADS/releases/download/v${MADS_VERSION}/mads-${MADS_VERSION}-Linux-x86_64.deb && \
      dpkg -i mads-${MADS_VERSION}-Linux-x86_64.deb && \
      rm mads-${MADS_VERSION}-Linux-x86_64.deb ;\
    else \
      echo "Unsupported architecture: '${TARGETPLATFORM}'" && \
      exit 1 ;\
    fi

USER mads
WORKDIR /home/mads
VOLUME ["/usr/local/etc"]
EXPOSE 9090
EXPOSE 9091
EXPOSE 9092
ENTRYPOINT ["/usr/local/bin/mads"]
CMD ["broker"]