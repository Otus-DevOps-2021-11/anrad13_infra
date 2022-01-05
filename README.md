# anrad13_infra
anrad13 Infra repository
starten ab 16-12-2021

# HW-5 cloud-bastion configuration
bastion_IP = 51.250.13.21
someinternalhost_IP = 10.128.0.23

## Connection in one line
1) put the public key into the ~/.ssh/authorized_keys file on someinternalhost
2) use ssh -J appuser@51.250.13.21 appuser@10.128.0.23

## Connection by host name
1) put the public key into the ~/.ssh/authorized_keys file on someinternalhost
2) create ~/.ssh/config with configuration:
Host bastion
  Hostname 51.250.13.21 # bastion ip
  User appuser
  IdentityFile /home/anrad14/.ssh/appuser

Host someinternalhost
  Hostname 10.128.0.23 # someinternalhost ip
  User appuser
  ProxyCommand ssh -W %h:%p bastion
  IdentityFile /home/anrad14/.ssh/appuser # absolute path to connection user private key

# HW-6 cloud-testapp
testapp_IP = 51.250.4.45
testapp_port = 9292
## Addiitional
- startup.sh - script for creation reddit-app instance by yc cli as "yc compute instance create ..."
- cloud_config.yaml -cloud-config for instance init during the first time boot. Includes user definition with pkey and runcmd sentences for application deploy

# HW-7 Packer
- builder config ubuntu16.json with variables.json and install_mongodb.sh, install_ruby
- builder config immutable.json with variables.json and install_mongodb.sh, install_ruby.sh, install_reddit.sh
- script for creating VM with predefined image (that was created by immutable.json)
### Как запустить проект:
- to build image with ruby and mongo from REPO_HOME/packer - execute "packer build -var-file=variables.json ubuntu16.json"
- to build image with ruby,mongo and reddit from REPO_HOME/packer - execute "packer build -var-file=variables.json immutable.json"
- to create VM with ruby,mongo and reddit from REPO_HOME/packer/config-scripts execute "create-reddit-vm.sh"

# HW-8 Terraform-1
- created main.tf with external variables.tf and output.tf
- performed selftasks - variable for provisioner connection, zone variable with predefined value, terraform fmt
- tasks with ** was not be accomplished

