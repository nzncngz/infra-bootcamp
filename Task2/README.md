# Ansible Postgresql Installation Lab

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
    
    
# Installation

``` bat  
$ git clone https://github.com/nzncngz/infra-bootcamp.git
```

vm creating. All vm controlled ubuntu vm so login to 192.168.1.19 with ssh key

``` bat  
$ vagrant up &
$ cd infra-bootcamp/Task2/ansible
$ ssh -i .vagrant/machines/control/virtualbox/private_key vagrant@192.168.135.19
```

Disable firewall

``` bat  
$ ansible-playbook playbooks/10_security.yml
```

Installation telnet,net-tools and lvm

``` bat  
$ ansible-playbook  playbooks/20_packages.yml

```

The second disk must be manually added via virtual box on 3 vm with centos OS. We will create volume groups on the physical disk and  will create 8 logical volumes of 640MB each and mount the file system on it. Minio server are running same as Distributed Mode.
``` bat  
$ ansible-playbook  playbooks/30_logical_volume_management.yml
```
We will define roles minio server by downloading the easkay.minio role via ansible galaxy. 

``` bat  
$ sudo ansible-galaxy install -r requirements.yml
```

Now we install minio server with roles/easkay.minio. While the installation is done tuning, logging, log rotate operations will be applied for the minio.


``` bat  
$ ansible-playbook  playbooks/cluster-setup.yml
```

# Role Variables

This role has multiple variables. The descriptions and defaults for all these variables can be found in the ansible/playbooks folder in the following files:




| Name           |   Description                         
| -------------  |   :-------------:          
|20_packages.yml |   installation telnet,postgresql packages  


| Name                             |   Description                         
| -------------                    |   :-------------:          
| 30_logical_volume_management.yml |   creating file system with LVM  


| Name               |   Description                         
| -------------      |   :-------------:          
| requirements.yml   |  define minio role with ansible galaxy 


| Name                 |   Description                         
| -------------        |   :-------------:          
| cluster-setup.yml    |   installation minio server 



defaults/ folder in the following files:

| Name                                   |   Description                         
| -------------                          |   :-------------:          
| playbooks/roles/common/tasks/main.yml  |   define minio run work and log directory


# Result

List of file system for three nodes. All minio services run cluster mode. I created a bucket on the first node and saw that this bucket was created on 3 servers at the same time.

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

https://sysadmins.co.za/setup-a-4-node-distributed-minio-cluster/

https://github.com/easkay/ansible-minio

https://github.com/husnusensoy/infra-bootcamp

https://galaxy.ansible.com/tklo/minio


