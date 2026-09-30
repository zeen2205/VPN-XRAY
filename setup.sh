#!/usr/bin/env bash
set -e
apt-get update
apt-get install -y curl wget unzip ca-certificates openssh-server python3 jq uuid-runtime procps iproute2 net-tools
mkdir -p /etc/xray /var/log/xray /run/sshd
curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh -o /tmp/install-xray.sh
chmod +x /tmp/install-xray.sh
/tmp/install-xray.sh install
rm -f /tmp/install-xray.sh
