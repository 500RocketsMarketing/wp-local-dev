#!/bin/bash

volumePath=$(docker volume inspect --format '{{ .Mountpoint }}' docker_demo_site)
rsync -av "$volumePath/" html 

docker exec docker_mariadb_1 /bin/sh -c 'mysqldump -u root -proot demo_db > initdata.sql'
docker cp docker_mariadb_1:/initdata.sql initdata.sql
