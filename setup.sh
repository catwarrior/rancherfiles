#!/bin/bash
mkdir -p /etc/docker
touch /etc/docker/daemon.json
echo { \"registry-mirrors\": [\"https://iakbs8nw.mirror.aliyuncs.com\"], \"insecure-registries\": [\"42.159.29.145:18083\"] } > /etc/docker/daemon.json
systemctl enable docker.service
systemctl restart docker.service
