#!/bin/bash
az group create -n vmssrg3 -l chinanorth
az vm create -g vmssrg3 -n ranchermaster \
--authentication-type password --admin-username myadmin --admin-password Admin@1234567890 \
--use-unmanaged-disk --storage-sku Standard_LRS \
--size Basic_A3 \
--image SUSE:SLES:12-SP2:2017.03.20 \
--subnet /subscriptions/96e96992-4c36-4b58-a68f-ecbfb1f1b79e/resourceGroups/xmbafcmcnbeinfvnt001rg/providers/Microsoft.Network/virtualNetworks/XMBAFCMCNINFVNT001RG/subnets/XMBAFCMCNINFS03DB \
--public-ip-address ""
az vm extension set \
  --resource-group vmssrg3 \
  --vm-name ranchermaster \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"fileUris": ["https://raw.githubusercontent.com/catwarrior/rancherfiles/master/rancher-master.sh"],"commandToExecute": "./rancher-master.sh"}'
