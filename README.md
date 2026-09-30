# Railway Ubuntu 24.04 + SSH + Xray VMess

This project installs OpenSSH and Xray-core in an Ubuntu 24.04 Railway container.

## Environment variables

- `UUID` — optional VMess UUID. If omitted, a random UUID is generated on startup.
- `SSH_PASSWORD` — root SSH password.
- `SSH_PORT` — internal SSH port, default `2222`.
- `XRAY_PORT` — internal Xray port, default `8080`.

## Railway

Deploy the repository as a Docker service. Add a Railway TCP Proxy for `XRAY_PORT` if you need public TCP access. Add another TCP Proxy for `SSH_PORT` if you need public SSH access. The public proxy port may differ from the internal port.

## VMess client

- Address: Railway TCP Proxy domain
- Port: Railway TCP Proxy public port
- UUID: value of `UUID` (or the UUID printed in deployment logs)
- AlterID: `0`
- Network: `ws`
- Path: `/vmess`
- TLS: configure according to the public endpoint you use

V2RayM is a client application; it is not installed as a server component here.
