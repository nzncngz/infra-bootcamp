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
    
    
# Installation

``` bat  
$ git clone https://github.com/nzncngz/nazancengiz.git
```

vm creating. All vm controlled ubuntu vm so login to 192.168.1.19 with ssh key

``` bat  
$ vagrant up &
$ cd nazancengiz/Task2/ansible
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
$ ansible-playbook  playbooks/40_install_minio_server.yml
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


| Name                    |   Description                         
| -------------           |   :-------------:          
| 40_install_minio_server |   installation minio server 



defaults/ folder in the following files:

| Name           |   Description                         
| -------------  |   :-------------:          
| main.yml       |   define tuning parameter,logrotate and logging for minio service




# Result

List of file system
Minio service referer three endpoints(http://192.168.135.12,http://192.168.135.13,http://192.168.135.14)

![minio](https://user-images.githubusercontent.com/22845579/118562472-6ea07c00-b775-11eb-94dc-446e8d64f6b1.png)



On below show minio service status

![service](https://user-images.githubusercontent.com/22845579/118335398-3f410380-b518-11eb-902b-26c4fc1915bd.png)


# Reference

https://github.com/easkay/ansible-minio

https://github.com/husnusensoy/infra-bootcamp

https://galaxy.ansible.com/tklo/minio


