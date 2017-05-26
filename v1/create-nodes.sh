#!/bin/bash
az vmss create --name rancher3 --resource-group vmssnodesrg  --location chinanorth --instance-count 2 --vm-sku Standard_A3 \
--authentication-type password --admin-username myadmin --admin-password Admin@1234567890 \
--use-unmanaged-disk --storage-sku Standard_LRS \
--upgrade-policy-mode Automatic \
--image SUSE:SLES:12-SP2:2017.03.20 --output table \
--subnet /subscriptions/96e96992-4c36-4b58-a68f-ecbfb1f1b79e/resourceGroups/xmbafcmcnbeinfvnt001rg/providers/Microsoft.Network/virtualNetworks/XMBAFCMCNINFVNT001RG/subnets/XMBAFCMCNINFS03DB \
--load-balancer "" --public-ip-address ""
az vmss extension set \
  --resource-group vmssnodesrg \
  --vmss-name rancher3 \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"fileUris": ["https://raw.githubusercontent.com/catwarrior/rancherfiles/master/v1/rancher-slaves.sh"],"commandToExecute": "./rancher-slaves.sh $1"}'
az vmss update-instances --instance-ids "*" -n rancher3 -g vmssnodesrg
