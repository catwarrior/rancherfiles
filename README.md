# rancherfiles

Purpose:
  with these scripts, you can bring up a rancher cluster quickly.
  
Steps:
  1. Azure cli 2.0 installed.
  2. Run script
  
     `./create-master.sh`
  3. Open rancher gui, create environment, add prviate registry if using kubernetes intranet or in china, add private registry
  4. Run script
  
     `export group_name=vmssrg15 cluster_name=vmssrg15 rancher_api=http://172.21.1.196:8080/v1/scripts/34BB720F8333A846BC96:1483142400000:REn3UXk1xKdrU6Chc8bCGfWARgw`
     `./create-slaves.sh`

Tips:
  Scale vmss ` az vmss scale --new-capacity 5 -n rancher3 -g vmssrg3`

# Auto clean up dead hosts on rancher.
1. Monitoring on rancher with rancher cli.
2. Remove the hosts when it under `DISCONNECTED` or `INACTIVE` via calling rancher cli.
3. Sample script:
`  
  #!/bin/sh
  while :
  do
      echo "Checking for inactive hosts every $INTERVAL seconds..."
      rancher hosts -a | grep -E 'disconnected' | while read LINE1
      do
          HOST=$(echo $LINE1 | cut -d ' ' -f 1)
          echo "stop $LINE1"
          rancher stop --type host $HOST
      done
      sleep $INTERVAL
      rancher hosts -a | grep -E 'inactive' | while read LINE
      do
          HOST=$(echo $LINE | cut -d ' ' -f 1)
          echo "Delete $LINE"
          rancher rm --type host $HOST
      done
      sleep $INTERVAL
  done
 ` 
  https://hub.docker.com/r/catwarrior/rancher-purge/
 
