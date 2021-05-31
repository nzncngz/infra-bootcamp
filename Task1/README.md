# Ansible Postgresql Installation Lab

Lab environment on below
Two vm created with Vagrant


| VM name       |   Role              | OS       |  Networking     | 
| ------------- |   :-------------:   | -----:   | -----:          |
| control       |   Ansible Host      | ubuntu   | 192.168.135.10  |
| postgresql    |   Postgresql        | centos 7 | 192.168.135.112 |


# Prerequisites

    Vagrant        2.2.15 
    Virtualbox     6.1.18 
    Postgresql     11
    
    
# Installation

``` bat  
$ git clone https://github.com/nzncngz/infra-bootcamp.git
```

vm creating. All vm controlled ubuntu vm so login to 192.168.1.10 with ssh key

``` bat  
$ vagrant up &
$ cd nazancengiz/Task1/ansible
$ ssh -i .vagrant/machines/control/virtualbox/private_key vagrant@192.168.135.10
```

Disable firewall

``` bat  
$ ansible-playbook playbooks/10_security.yml
```

Installation Postgresql and other requirements

``` bat  
$ ansible-playbook  playbooks/20_packages.yml

```

Now new user and database creating, set password for new user and all role assign to.

``` bat  
$ ansible-playbook  playbooks/30_configure_postgre.yml
```
We want backup database on another file system. It has to be stored with logical volume management. Database vm must be stopped before the playbook can be run.

The second disk must be added manually via the virtualbox.

``` bat  
$ ansible-playbook  playbooks/40_logical_volume_management.yml
```

Finally backup and restore for postgresql for new database

``` bat  
$ ansible-playbook playbooks/50_backup_restore.yml
```
# Role Variables

This role has multiple variables. The descriptions and defaults for all these variables can be found in the ansible/playbooks folder in the following files:




| Name           |   Description                         
| -------------  |   :-------------:          
|20_packages.yml |   installation telnet,postgresql packages  


| Name                             |   Description                         
| -------------                    |   :-------------:          
| 40_logical_volume_management.yml |   creating backup directory for LVM  


| Name                     |   Description                         
| -------------            |   :-------------:          
| 30_configure_postgre.yml |   new user,database adding postgresql database 


| Name                  |   Description                         
| -------------         |   :-------------:          
| 50_backup_restore.yml |   dump and restore on postgresql


defaults/ folder in the following files:

| Name           |   Description                         
| -------------  |   :-------------:          
| main.yml       |   define user,password variable

templates/ folder in the following files:

| Name               |   Description                         
| -------------      |   :-------------:          
| postgresql.conf.j2 |   setting tunning parameters


# Result

List of volume group and logical volume

![logical_volume_and_volume_group_484x640_300x396](https://user-images.githubusercontent.com/22845579/117537168-ff55ba00-b007-11eb-9e90-084e3e47a850.jpg)


On below show creating backup file 

![result_postgre_backup](https://user-images.githubusercontent.com/22845579/117503838-36858600-af8a-11eb-9c35-9cc4cbbc0b41.png)



# Reference

https://stribny.name/blog/ansible-postgresql-backups/

https://www.happycoders.eu/devops/ansible-tutorial-setup-docker-mysql-wordpress/

https://github.com/azavea/ansible-postgresql

https://www.postgresqltutorial.com/postgresql-list-users/
