# Using these playbooks

These playbooks are a guideline for building your own automation. You may not elect to run all the playbooks here. You mmay elect to enhance these or take different opinions on how to do things. Contributions are appreciated for common setups.

## Setting up your ansible control node

You should have a VM or container for ansible from which to execute these playbooks in an automated fashion.

Install ansible. Recent versions of Ubuntu contain a new enough version for these playbooks.

    sudo apt install ansible

Set up an ansible user and create an SSH key for the user.

    sudo useradd -m -s /bin/bash ansible
    sudo -u ansible mkdir /home/ansible/.ssh
    sudo -u ansible ssh-keygen -t rsa -b 8192
    sudo -u ansible chmod 700 /home/ansible/.ssh
    sudo -u ansible chmod 600 /home/ansible/.ssh/id_rsa

Retreive the ansible user public key for later use.

    sudo -u ansible cat /home/ansible/.ssh/id_rsa.pub

## Setting up your ansible hosts file

Set up the ansible hosts file to reflect your infrastructure. Your day will be nicer if you have all of these in DNS.

Put each piece of infra in the relevant section. 

* VMs
* Containers
* Cloud
* Baremetal

A host can appear in one or more sections. eg a host may be a VM in the cloud.

eg.

    [ubuntucts]
    ubuntuct1
    ubuntuct2
    
    [ubuntuvms]
    ubuntuvm1
    ubuntuvm2
    ubuntuvm3
    
    [cloud]
    ubuntuvm3

This allows you to make selections such as ubuntuvms:!cloud to select all Ubuntu VMs not in the cloud.

## Setting up your remote hosts

Configure remote.sh to include your ansible key.

    sed -i 's/^ANSIBLE_SSH_KEY=$/ANSIBLE_SSH_KEY=your ssh key here/' remote.sh

Run setup.sh to configure the ansible user and add the ansible public key to the remote.

    ./setup.sh user@host

Example:

    ./setup.sh hostheaduser@example.org

The user must have sudo privilges without requiring a password to execute this script.

## Running the playbooks

To run a playbook, execute the following on the ansible control node as the ansible user.

    sudo su - ansible
    ansible-playbook -i path/to/hosts path/to/playbook.yml

For example

    sudo su - ansible
    ansible-playbook -i hosts playbooks/apt-update-and-restart-services.yml

You may elect to put this into a cron job for the ansible user

    sudo crontab -eu ansible

If you cannot navigate vi, prepend the command (but after the sudo) with EDITOR=nano

    sudo EDITOR=nano crontab -eu ansible

Add the following contents
    0 3 * * * cd /home/ansible && ansible-playbook -i hosts playbooks/apt-update-and-restart-services.yml > logs/apt-update-and-restart-services.log
