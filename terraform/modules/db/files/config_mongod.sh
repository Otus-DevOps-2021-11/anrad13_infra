#!/bin/bash

sleep 30

sudo mv /tmp/mongod.conf /etc/mongod.conf
sudo systemctl restart mongod
