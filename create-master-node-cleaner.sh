#!/bin/bash
az vm extension set \
  --resource-group vmssrg3 \
  --vm-name ranchermaster \
  --name customScript1 \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"fileUris": ["https://raw.githubusercontent.com/catwarrior/rancherfiles/master/rancher-master.sh"],"commandToExecute": "./rancher-master.sh"}'
