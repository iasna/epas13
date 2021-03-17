# epas13
Enterprise postgres advanced server 13 docker file

# How to build the image 
docker build . -t epas13
# How to start a container
docker run -d  -p 5444:5444 --name  epas13-server epas13

# How to connect pgsql command line 
docker exec -it epas13-server /usr/edb/as13/bin/psql -h localhost -p 5444 -d postgres -U enterprisedb
