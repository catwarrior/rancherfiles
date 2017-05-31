# rancherfiles

Purpose:
  with these scripts, you can bring up a rancher cluster quickly.
  
Steps:
  1. Azure cli 2.0 installed.
  2. Run script
     > ./create-master.sh
  3. Open rancher gui, create environment, add prviate registry if using kubernetes intranet or in china, add private registry
  4. Run script
     > export group_name=vmssrg15 cluster_name=vmssrg15 rancher_api=http://172.21.1.196:8080/v1/scripts/34BB720F8333A846BC96:1483142400000:REn3UXk1xKdrU6Chc8bCGfWARgw
     > ./create-slaves.sh

Tips:
  Scale vmss ` az vmss scale --new-capacity 5 -n rancher3 -g vmssrg3`
  
  Remove disconnected vms periodically https://hub.docker.com/r/wmbutler/rancher-purge/
