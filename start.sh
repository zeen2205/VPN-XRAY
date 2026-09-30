#!/usr/bin/env bash
set -e
UUID="${UUID:-$(cat /proc/sys/kernel/random/uuid)}"
SSH_PORT="${SSH_PORT:-2222}"
XRAY_PORT="${XRAY_PORT:-8080}"

mkdir -p /run/sshd /etc/xray

if [ -n "${SSH_PASSWORD:-}" ]; then
  echo "root:${SSH_PASSWORD}" | chpasswd
fi

sed -i "s/^#\?Port .*/Port ${SSH_PORT}/" /etc/ssh/sshd_config
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

grep -q "^Port ${SSH_PORT}$" /etc/ssh/sshd_config || echo "Port ${SSH_PORT}" >> /etc/ssh/sshd_config

sed -e "s|\${UUID}|${UUID}|g" -e "s|\${XRAY_PORT}|${XRAY_PORT}|g" /etc/xray/config.json.template > /etc/xray/config.json

xray run -test -config /etc/xray/config.json
/usr/sbin/sshd

echo "======================================"
echo "Railway Xray server started"
echo "VMess WS path: /vmess"
echo "UUID: ${UUID}"
echo "Xray internal port: ${XRAY_PORT}"
echo "SSH internal port: ${SSH_PORT}"
echo "======================================"

exec xray run -config /etc/xray/config.json
