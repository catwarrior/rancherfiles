#!/bin/bash
mkdir -p /etc/docker
touch /etc/docker/daemon.json
echo { \"registry-mirrors\": [\"https://iakbs8nw.mirror.aliyuncs.com\"], \"insecure-registries\": [\"42.159.29.145:18083\"], \"storage-driver\": \"overlay2\" } > /etc/docker/daemon.json
systemctl enable docker.service
systemctl restart docker.service
vmname=`cat /proc/sys/kernel/random/uuid| cksum | cut -f1 -d" "`
hostname $vmname
## start rancher master
docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
