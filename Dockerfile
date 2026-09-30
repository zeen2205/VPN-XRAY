FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl wget unzip ca-certificates openssh-server python3 jq uuid-runtime procps iproute2 net-tools && rm -rf /var/lib/apt/lists/*
COPY setup.sh /setup.sh
COPY start.sh /start.sh
COPY xray-config.json.template /etc/xray/config.json.template
RUN chmod +x /setup.sh /start.sh && /setup.sh
EXPOSE 8080
CMD ["/start.sh"]
