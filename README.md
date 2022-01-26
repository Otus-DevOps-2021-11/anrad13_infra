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

# HW-9 Terraform-2
- created modules app, db
- created prod and stage terraform projects with modules usage
- task with * was not accomplished
## Task with ** (add provisioners)
- module app: provisioner for clone app and set up puma systemd
- module app: provisioner for creating env file for puma systemd. Env file contains DATABASE_URL as result of "echo DATABASE_URL=${var.db_address} > /home/ubuntu/reddit-env", where ${var.db_address} - local address of db instance
- module db: provisioner for changing default mongod config to bindIp: 0.0.0.0

# HW-10 Ansible-1
- A1 (slide #32) - after rm ~/redit, the running of clone playbook, has shown that ansible restored repo again and output became again (appserver                  : ok=2    changed=1)
## Task with *
- docs - https://nklya.medium.com/%D0%B4%D0%B8%D0%BD%D0%B0%D0%BC%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%BE%D0%B5-%D0%B8%D0%BD%D0%B2%D0%B5%D0%BD%D1%82%D0%BE%D1%80%D0%B8-%D0%B2-ansible-9ee880d540d6
- create a file inventory.json in ansible dynamic format with static host ip addresses
- create executable inventory.sh script
- inventory.sh --list will output the ./inventory.json
- inventory.sh --host will output {}

# HW-11 Ansible-2
- inventory - active inventory file
- reddit_app_one_play.yml - configure and deploy Reddit in one playbook in one file
- reddit_app_multiple_plays.yml - configure and deploy Reddit in multiply playbook in one file
- site.yml, app.yml, db.yml, deploy.yml - configure and deploy Reddit in multiply playbook in separated files
- packer_app.yml, packer_db.yml - provisioners playbook for creating a base images by packer
- packer/app.json, packer/db.json - packer build config with ansible json. *_with_script.json - prev version of packer's configs
- terraform/stage/variables.tf uses new disk images built by packer with ansible playbook
## Как запустить проект:
1. go to repo root and execute:
- to create base db image - packer build -var-file=./packer/variables.json packer/db.json. Put image id to terraform/stage/variables.tf (variable db_disk_image)
-  to create base app image - packer build -var-file=./packer/variables.json packer/app.json. Put image id to terraform/stage/variables.tf (variable app_disk_image)
2. go to terraform/stage/ and run terraform apply. get output and:
- put db local address to ansible/app.yml -> vars:   db_host: {db local address}
- put app and db external addresses to ansible/inventory file
3. go to ansible and run -  ansible-playbook site.yml to configure hosts and deploy reddit

## Как проверить работоспособность:
 - go to app_external_ip:9292 and check Reddit

# HW-12 Ansible-3
- createed roles db, app in ./roles
- installed role jdauphant.nginx to ./roles
- createed ./environments with stage and prod env
- created credentials.yml files (./environments/prod|stage), encripted them. Created user.yml playbook and add it to site.yml playbook
- moved git instalation from app playbook to packer_app playbook
- rearranged ansible dir with ./old and ./playbooks
- checked all with real deployment
## Как запустить проект:
-see HW-11 Ansible-2
