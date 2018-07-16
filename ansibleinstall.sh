#/bin/bash
echo "Update the repo details"
apt-add-repository ppa:ansible/ansible
echo "update the packages"
apt update
echo "Install Ansible"
apt install ansible python-pip -y
echo "install boto tools"
/usr/bin/python -m easy_install pip
/usr/bin/python -m pip install boto
/usr/bin/python -m pip install boto3
/usr/bin/python -m pip install docker-compose
