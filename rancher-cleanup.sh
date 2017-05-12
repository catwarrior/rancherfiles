#!/bin/bash

docker rm -f $(docker ps -aq)

rm -rf /var/etcd/

for m in $(tac /proc/mounts | awk '{print $2}' | grep /var/lib/kubelet);do
    umount $m || true
done

rm -rf /var/lib/kubelet/

for m in $(tac /proc/mounts | awk '{print $2}' | grep /var/lib/rancher);do
    umount $m || true
done

rm -rf /var/lib/rancher/

rm -rf /run/kubernetes/

docker volume rm $(docker volume ls -q)

docker ps -a
docker volume ls

# curl -sSL https://raw.githubusercontent.com/catwarrior/rancherfiles/master/rancher-cleanup.sh | sh
