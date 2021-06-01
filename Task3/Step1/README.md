# Ansible Postgresql Table Add Data

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
    Python         2.7
    
# Note   

1) Minio sdk must be installed for python 
2) You must do all the steps in Task1 in the same repo before this task.

# Installation

``` bat  
$ git clone https://github.com/nzncngz/infra-bootcamp.git
```

vm creating. All vm controlled ubuntu vm so login to 192.168.1.10 with ssh key

``` bat  
$ vagrant up &
$ cd infra-bootcamp/Task3/Step1/ansible
$ ssh -i .vagrant/machines/control/virtualbox/private_key vagrant@192.168.135.10
```

Import data to postgresql table

``` bat  
$ ansible-playbook playbooks/60_data_import_database.yml
```
First, let's download the csv file containing the traffic flow. We imported all the data in the csv file into the table on postgresql.

The created database is connected and the tables are displayed. In the following output, it can be seen that the traffic_density6 table has been created by connecting to the newdbtest database.

# Output

``` bat 
$ psql -U postgres -d postgres -h 127.0.0.1 -w
psql (11.12)
Type "help" for help.

postgres=# \c newdbtest
You are now connected to database "newdbtest" as user "postgres".
newdbtest=# \dt
List of relations
 Schema |       Name       | Type  |  Owner   
--------+------------------+-------+----------
 public | traffic_density  | table | postgres
 public | traffic_density3 | table | postgres
 public | traffic_density4 | table | postgres
 public | traffic_density6 | table | postgres
(4 rows)

```

# Role Variables

This role has multiple variables. The descriptions and defaults for all these variables can be found in the ansible/playbooks folder in the following files:


| Name                       |   Description                         
| -------------              |   :-------------:          
|60_data_import_database.yml |   download csv file, import csv file on postgresql database


defaults/ folder in the following files:

| Name           |   Description                         
| -------------  |   :-------------:          
| main.yml       |   define database name, user,password, table variable

templates/ folder in the following files:

| Name           |   Description                         
| -------------  |   :-------------:          
| import_data.j2 |   csv files will be transferred to the table on the database via the python script here.


# Result

List of content of postgresql table

![show_tables](https://user-images.githubusercontent.com/22845579/120142121-69681600-c1e6-11eb-9dcd-77fefa0176b2.png)


# Reference

https://www.postgresqltutorial.com/postgresql-python/connect/

https://www.dataquest.io/blog/loading-data-into-postgres/

https://stackoverflow.com/questions/26040493/how-to-show-data-in-a-table-by-using-psql-command-line-interface

