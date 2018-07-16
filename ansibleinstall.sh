#/bin/bash
echo "Update the repo details"
apt-add-repository ppa:ansible/ansible
echo "update the packages"
apt update
echo "Install Ansible"
apt install ansible