#!/bin/bash
mkdir -p /etc/docker
touch /etc/docker/daemon.json
echo { \"registry-mirrors\": [\"https://iakbs8nw.mirror.aliyuncs.com\"], \"insecure-registries\": [\"42.159.29.145:18083\"], \"storage-driver\": \"overlay2\" } > /etc/docker/daemon.json
systemctl enable docker.service
systemctl restart docker.service
## start rancher master
docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable

## start rancher nodes cleaner
# docker run -d --restart=unless-stopped \
#  -e RANCHER_ACCESS_KEY=02579406B155C15055D0 \
#  -e RANCHER_SECRET_KEY=hmtAU1QhzssELTi3pJdarzFK9GxRN2FU5hUihSCh \
#  -e RANCHER_URL=http://172.21.1.196:8080/v2-beta/schemas \
#  -e RANCHER_ENVIRONMENT=1a7 \
#  -e INTERVAL=30
