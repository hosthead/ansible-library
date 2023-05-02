#!/bin/bash

ANSIBLE_SSH_KEY=

useradd -m -s /bin/bash ansible
mkdir /home/ansible/.ssh
echo "${ANSIBLE_SSH_KEY}" >> /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible/.ssh
chmod 700 /home/ansible/.ssh
chmod 600 /home/ansible/.ssh/authorized_keys
echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
