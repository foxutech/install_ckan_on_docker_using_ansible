# Scope
  Deploy Ckan on ubuntu 16.04
   
# Steps:

  Here i have drafted two major steps to deploy ckan on Ubuntu 16.04.
  
# Step1: provision a instance on AWS

   Before deploy, let provision a required system in aws/ any of you cloud provider. In this i have covered AWS. 
   
   before provision, we have to mention the required aws variable like security group, subnet and key value, this you can automate, as already i have some existing environment, i reused it. your environment variable should look like this:
   
$ cat /provision-ec2/aws_variables/vars.yml   
ec2_keypair: "keyfile name"
ec2_security_group: "sg-xxxxxxxxxxxxxxx"
ec2_instance_type: "t2.micro"
ec2_image: "ami-ba602bc2"
ec2_subnet_ids: ['subnet-xxxxxxxxxxxxxxxx']
ec2_region: "us-west-2"
ec2_tag_Name: "dataserver"
ec2_tag_Type: "dataserver"
ec2_tag_Environment: "development"
ec2_volume_size: 20

 once you set all the variable, then install the boto3 to setup AWS credentials using following command on localhost.
 
$ sudo apt install python-pip
 
$ sudo pip install boto
 
$ sudo vim ~/.boto

[Credentials] 

aws_access_key_id = HIDDEN 

aws_secret_access_key = HIDDEN

 Once you done, you are good to go for run a playbook.

$ sudo ansible-playbook provision-ec2/provision-ec2.yml -vvv

 Once it run successfully, you can see the instance details on your AWS. 

# Step2: Install docker and deploy the application

 To install docker, run a following command on the machine, where have to install it. 
 
$ cd repo-path/ckan
  
$ sudo ansible-playbook dockerinstall.yml -vvv
 
 once docker installed successfully, you can run following command deploy the ckan application on same directory. 
 
$ sudo ansible-playbook service.yml -vvv
 
 If you are running remotely, use ec2.py to fetch your ec2 instance details. (as my case, kept in same working folder) you can change directory. 
 
export EC2_INI_PATH=/root/install_ckan_on_docker_using_ansible/provision-ec2/ec2.ini

export ANSIBLE_INVENTORY=/root/install_ckan_on_docker_using_ansible/provision-ec2/ec2.py

 this helps enable dynamic host on playbook.
