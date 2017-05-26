#!/bin/bash
az vm extension set \
  --resource-group vmssrg3 \
  --vm-name ranchermaster \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"commandToExecute": "docker run -d --restart=unless-stopped -e RANCHER_ACCESS_KEY=02579406B155C15055D0 -e RANCHER_SECRET_KEY=hmtAU1QhzssELTi3pJdarzFK9GxRN2FU5hUihSCh -e RANCHER_URL=http://172.21.1.196:8080/v2-beta/schemas -e RANCHER_ENVIRONMENT=1a7 -e INTERVAL=30 catwarrior/rancher-purge"}'
