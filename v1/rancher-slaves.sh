#!/bin/bash
mkdir -p /etc/docker
touch /etc/docker/daemon.json
echo { \"registry-mirrors\": [\"https://iakbs8nw.mirror.aliyuncs.com\"], \"insecure-registries\": [\"42.159.29.145:18083\"], \"storage-driver\": \"overlay2\" } > /etc/docker/daemon.json
systemctl enable docker.service
systemctl restart docker.service
sleep 3
## add nodes
docker run --rm --privileged \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/rancher:/var/lib/rancher \
  rancher/agent:v1.2.2 $1
