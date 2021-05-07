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
$ git clone https://github.com/nzncngz/nazancengiz.git
```

vm creating. All vm controlled ubuntu vm so login to 192.168.1.10 with ssh key

``` bat  
$ vagrant up &
$ cd nazancengiz/Task1/ansible
$ ssh -i .vagrant/machines/control/virtualbox/private_key vagrant@192.168.135.10
```

Disable firewall

``` bat  
$ ansible-playbook -i hosts tasks/10_security.yml
```

Installation Postgresql and other requirements

``` bat  
$ ansible-playbook -i hosts tasks/20_packages.yml

```

Now new user and database creating, set password for new user and all role assign to.

``` bat  
$ ansible-playbook -i hosts tasks/30_configure_postgre.yml
```
We want backup database on another file system. It has to be stored with logical volume management.

``` bat  
$ ansible-playbook -i hosts tasks/40_logical_volume_management.yml
```

Finally backup and restore for postgresql for new database

``` bat  
$ ansible-playbook -i hosts tasks/50_backup_restore.yml
```


# Result

List of volume group and logical volume

![logical_volume_and_volume_group](https://user-images.githubusercontent.com/22845579/117504043-86644d00-af8a-11eb-8708-b9170435dfd8.png)


On below show creating backup file 

![result_postgre_backup](https://user-images.githubusercontent.com/22845579/117503838-36858600-af8a-11eb-9c35-9cc4cbbc0b41.png)



# Reference

https://stribny.name/blog/ansible-postgresql-backups/

https://www.happycoders.eu/devops/ansible-tutorial-setup-docker-mysql-wordpress/

https://github.com/azavea/ansible-postgresql

https://www.postgresqltutorial.com/postgresql-list-users/
