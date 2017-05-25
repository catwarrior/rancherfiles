# rancherfiles

Purpose:
  with these scripts, you can bring up a rancher cluster quickly.
  
Steps:
  1. Azure cli 2.0 installed.
  2. > create-master.sh
  3. Open rancher gui, create environment, add prviate registry if using kubernetes intranet or in china, add private registry
  4. > create-slaves.sh %rancher-add-node-api-uri%

Tips:
  Scale vmss ` az vmss scale --new-capacity 5 -n rancher3 -g vmssrg3`
  
  Remove disconnected vms periodically https://hub.docker.com/r/wmbutler/rancher-purge/
