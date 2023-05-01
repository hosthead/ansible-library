#!/bin/bash

useradd -m -s /bin/bash ansible
mkdir /home/ansible/.ssh
echo "pubkey for your ansible user here" > /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible/.ssh
chmod 700 /home/ansible/.ssh
chmod 600 /home/ansible/.ssh/authorized_keys
echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
