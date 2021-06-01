# Ansible Postgresql Installation Lab

Lab environment on below
Four vm created with Vagrant


| VM name       |   Role              | OS       |  Networking     | 
| ------------- |   :-------------:   | -----:   | -----:          |
| control       |   Ansible Host      | ubuntu   | 192.168.135.19  |
| vm1           |   Minio Server      | centos 7 | 192.168.135.12  |
| vm2           |   Minio Server      | centos 7 | 192.168.135.13  |
| vm3           |   Minio Server      | centos 7 | 192.168.135.14  |


# Prerequisites

    Vagrant        2.2.15 
    Virtualbox     6.1.18 
    Minio Server   latest
    Python          3
    
# Note

1) Minio sdk must be installed for python
2) You must do all the steps in Task1 in the same repo before this task.

# Installation

``` bat  
$ git clone https://github.com/nzncngz/infra-bootcamp.git
```

vm creating. All vm controlled ubuntu vm so login to 192.168.1.19 with ssh key

``` bat  
$ vagrant up &
$ cd infra-bootcamp/Task3/Step2/ansible
$ ssh -i .vagrant/machines/control/virtualbox/private_key vagrant@192.168.135.19
```

Now we purpose create a bucket if not existing on minio server and any example file(traffic_density_202001.csv) upload on bucket.
On playbook adding minio sdk for python.

``` bat  
$ ansible-playbook  playbooks/50_import_data.yml
```


# Role Variables

This role has multiple variables. The descriptions and defaults for all these variables can be found in the ansible/playbooks folder in the following files:

playbook folder in the following files:


| Name              |   Description                         
| -------------     |   :-------------:          
|50_import_data.yml |   minio sdk adding for python, connect minio server, create bucket, import csv file on bucket with script


templates folder in the following files:


| Name       |   Description                         
| ---------- |   :-------------:          
|data.j2     |   connect minio server, create bucket, import csv file on bucket


defaults/ folder in the following files:

| Name           |   Description                         
| -------------  |   :-------------:          
| main.yml       |   define bucket name, tuning parameter,logrotate and logging for minio service




# Result

List of file system for three nodes

![filesystem_list](https://user-images.githubusercontent.com/22845579/119223672-59c04180-bb03-11eb-93bf-fa8b2c1fde0d.jpg)


Minio service referer three endpoints(http://192.168.135.12,http://192.168.135.13,http://192.168.135.14)

On below show minio service status

vm1

![minio(3)](https://user-images.githubusercontent.com/22845579/119224141-b4f33380-bb05-11eb-9fc1-2aef9c37c0c3.jpg)

vm2

![minio2](https://user-images.githubusercontent.com/22845579/119226515-381a8680-bb12-11eb-83f7-a75a3c2875c7.jpg)

vm3

![minio3](https://user-images.githubusercontent.com/22845579/119226558-65ffcb00-bb12-11eb-8370-dbae014cea1f.jpg)

# Reference

https://docs.min.io/docs/python-client-quickstart-guide.html

https://sysadmins.co.za/using-minios-python-sdk-to-interact-with-a-minio-s3-bucket/

https://codereview.stackexchange.com/questions/226239/exporting-data-from-postgresql-as-csv-to-s3-bucket


