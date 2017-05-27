#!/bin/bash
#group_name=vmssnodesrg
#cluster_name=rancher3
#rancher_api=xx
az group create -n $(group_name) -l chinanorth
az vmss create --name $(cluster_name) --resource-group $(group_name) --location chinanorth --instance-count 2 --vm-sku Standard_A3 \
--authentication-type password --admin-username myadmin --admin-password Admin@1234567890 \
--use-unmanaged-disk --storage-sku Standard_LRS \
--image SUSE:SLES:12-SP2:2017.03.20 --output table \
--subnet /subscriptions/96e96992-4c36-4b58-a68f-ecbfb1f1b79e/resourceGroups/xmbafcmcnbeinfvnt001rg/providers/Microsoft.Network/virtualNetworks/XMBAFCMCNINFVNT001RG/subnets/XMBAFCMCNINFS03DB \
--load-balancer "" --public-ip-address ""
az vmss extension set \
  --resource-group $(group_name) \
  --vmss-name $(cluster_name) \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --settings "{\"fileUris\": [\"https://raw.githubusercontent.com/catwarrior/rancherfiles/master/v1/rancher-slaves.sh\"],\"commandToExecute\": \"./rancher-slaves.sh $(rancher_api)\"}"
az vmss update-instances --instance-ids "*" -n $(cluster_name) -g $(group_name)
