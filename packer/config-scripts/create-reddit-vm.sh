#!/bin/bash
yc compute instance create \
  --name reddit-app2 \
  --hostname reddit-app2 \
  --memory=4 \
--create-boot-disk name=disk1,size=10,image-id=fd8naqgobd8olqauag2e \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=cloud_config.yaml
