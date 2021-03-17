# epas13
Enterprise postgres advanced server 13 docker file

# How to build the image 
docker build . -t epas13
# How to start a container
docker run -d  -p 5444:5444 --name  epas13-server epas13

# How to connect pgsql command line 
docker exec -it epas13-server /usr/edb/as13/bin/psql -h localhost -p 5444 -d postgres -U enterprisedb

# Running migration toolkit
In container run 
 1. yum -y install edb-migrationtoolkit
 2. To confirm installation run 
 ``` vi /usr/edb/migrationtoolkit/etc/toolkit.properties```
 3. edit the toolkit.properties 
 Source database connectivity info...
``` 
conn =jdbc:oracle:thin:@ip:port:SID
user =username
password=******
Target database connectivity info...
conn =jdbc:edb://localhost:5444/edb
user =enterprisedb
password=****** 
```
 5. yum install jre
 6. outside the container run 
    docker cp ojdbc8-full.tar.gz /home
 6. in container run 
 ``` tar -xvf  ojdbc8-full.tar.gz```
 7. copy all contents to /usr/edb/migrationtoolkit/lib/ by running
 ``` cp OJDBC8-Full/*  /usr/edb/migrationtoolkit/lib/```
 8. cd /usr/edb/migrationtoolkit/bin 
 9. ./runMTK.sh
