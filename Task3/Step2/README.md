# Create A  Bucket And Import Data To Minio Server With Ansible

Lab environment on below
Four vm created with Vagrant


| VM name       |   Role              | OS       |  Networking     | 
| ------------- |   :-------------:   | -----:   | -----:          |
| control       |   Ansible Host      | centos 7 | 192.168.135.19  |
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

Just create a bucket on a random minio server. 

Since it works in distributed mode, buckets will be created on all 3 minio servers.(http://192.168.135.12,http://192.168.135.13,http://192.168.135.14)

The other all minio service are as follows
![minio_import_data](https://user-images.githubusercontent.com/22845579/120331275-49277c80-c2f6-11eb-89f4-0b0112e4e165.png)

# Reference

https://docs.min.io/docs/python-client-quickstart-guide.html

https://sysadmins.co.za/using-minios-python-sdk-to-interact-with-a-minio-s3-bucket/

https://codereview.stackexchange.com/questions/226239/exporting-data-from-postgresql-as-csv-to-s3-bucket


