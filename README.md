quickstart:

build the image:
```
 git clone https://github.com/davemo88/docker-pma
 cd docker-pma
 docker build -t pma ./
```
create the container pointing to your mysql server:
```
 docker run --name pma -p 443:443 -e MYSQL_HOST=mysql_host -d pma
```
or linked to a container running mysql:
```
 docker run --name pma -p 443:443 --link mysql_container -d pma
```
 
Assumes default mysql port
