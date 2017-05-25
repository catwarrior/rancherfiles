# rancherfiles

Purpose:
  with these scripts, you can bring up a rancher cluster quickly.
  
Steps:
  1. Azure cli 2.0 installed.
  2. > create-master.sh
  3. Open rancher gui, create environment, add prviate registry if using kubernetes intranet or in china, add private registry
  4. > create-slaves.sh %rancher-add-node-api-uri%
