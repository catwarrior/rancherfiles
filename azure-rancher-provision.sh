#!/bin/bash
az group create -n vmssrg3 -l chinanorth
az network vnet create -g vmssrg3 -n vmssvnet --address-prefix 10.0.0.0/16 --subnet-name vmssvnetsub1 --subnet-prefix 10.0.0.0/24

az vm create -g vmssrg3 -n jumpserver \
--authentication-type password --admin-username myadmin --admin-password Admin@1234567890 \
--use-unmanaged-disk --storage-sku Standard_LRS \
--size Basic_A3 \
--image SUSE:SLES:12-SP2:2017.03.20 \
--vnet-name vmssvnet --subnet vmssvnetsub1 \
--no-wait

az vm create -g vmssrg3 -n ranchermaster \
--authentication-type password --admin-username myadmin --admin-password Admin@1234567890 \
--use-unmanaged-disk --storage-sku Standard_LRS \
--size Basic_A3 \
--image SUSE:SLES:12-SP2:2017.03.20 \
--vnet-name vmssvnet --subnet vmssvnetsub1 \
--public-ip-address "" \
--no-wait

az vmss create --name rancher3 --resource-group vmssrg3 --location chinanorth --instance-count 2 --vm-sku Standard_A3 \
--authentication-type password --admin-username myadmin --admin-password Admin@1234567890 \
--use-unmanaged-disk --storage-sku Standard_LRS \
--image SUSE:SLES:12-SP2:2017.03.20 --output table \
--vnet-name vmssvnet --subnet vmssvnetsub1 \
--load-balancer "" --public-ip-address ""

az vm extension set \
  --resource-group vmssrg3 \
  --vm-name ranchermaster \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"fileUris": ["https://raw.githubusercontent.com/catwarrior/rancherfiles/master/setup.sh","https://raw.githubusercontent.com/catwarrior/rancherfiles/master/rancher-master.sh"],"commandToExecute": "./setup.sh & ./rancher-master.sh"}'

az vmss extension set '
  --resource-group vmssrg3 `
  --vmss-name rancher3 `
  --name customScript `
  --publisher Microsoft.Azure.Extensions `
  --settings '{"fileUris": ["https://raw.githubusercontent.com/catwarrior/rancherfiles/master/setup.sh"],"commandToExecute": "./setup.sh"}'


az vm extension set --resource-group vmssrg3 --vm-name vmmaster --name customScript --publisher Microsoft.Azure.Extensions --settings ./script-config.json --verbose --debug
az vmss extension set --resource-group vmssrg3 --vmss-name rancher3 --name customScript --publisher Microsoft.Azure.Extensions --settings ./script-config.json --verbose --debug

{
  "commandToExecute": "systemctl enable docker.service & systemctl restart docker.service"
}


 \
--custom-data /root/custom-data.yaml
