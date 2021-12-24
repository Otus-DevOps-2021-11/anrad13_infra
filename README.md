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
