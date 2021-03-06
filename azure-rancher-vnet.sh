#!/bin/bash
az group create -n vmssrg3 -l chinanorth

az vm create -g vmssrg3 -n ranchermaster \
--authentication-type password --admin-username myadmin --admin-password Admin@1234567890 \
--use-unmanaged-disk --storage-sku Standard_LRS \
--size Basic_A3 \
--image SUSE:SLES:12-SP2:2017.03.20 \
--subnet /subscriptions/96e96992-4c36-4b58-a68f-ecbfb1f1b79e/resourceGroups/xmbafcmcnbeinfvnt001rg/providers/Microsoft.Network/virtualNetworks/XMBAFCMCNINFVNT001RG/subnets/XMBAFCMCNINFS03DB \
--public-ip-address "" \
--no-wait

az vm extension set \
  --resource-group vmssrg3 \
  --vm-name ranchermaster \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"fileUris": ["https://raw.githubusercontent.com/catwarrior/rancherfiles/master/rancher-master.sh"],"commandToExecute": "./rancher-master.sh"}'

az vmss create --name rancher3 --resource-group vmssrg3 --location chinanorth --instance-count 2 --vm-sku Standard_A3 \
--authentication-type password --admin-username myadmin --admin-password Admin@1234567890 \
--use-unmanaged-disk --storage-sku Standard_LRS \
--image SUSE:SLES:12-SP2:2017.03.20 --output table \
--subnet /subscriptions/96e96992-4c36-4b58-a68f-ecbfb1f1b79e/resourceGroups/xmbafcmcnbeinfvnt001rg/providers/Microsoft.Network/virtualNetworks/XMBAFCMCNINFVNT001RG/subnets/XMBAFCMCNINFS03DB \
--load-balancer "" --public-ip-address ""

az vmss extension set \
  --resource-group vmssrg3 \
  --vmss-name rancher3 \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"fileUris": ["https://raw.githubusercontent.com/catwarrior/rancherfiles/master/rancher-slaves.sh"],"commandToExecute": "./rancher-slaves.sh http://172.21.1.196:8080/v1/scripts/3C99474E1D679EA93E60:1483142400000:qyqummPGyQLxnuEaA0MjnFrs"}'

az vmss update-instances --instance-ids "*" -n rancher3 -g vmssrg3
