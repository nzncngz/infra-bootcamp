#!/bin/bash
echo "Starting provisioning of Ansible..."

sudo yum -y update
sudo yum -y install epel-release
sudo yum -y update
sudo yum -y install ansible

