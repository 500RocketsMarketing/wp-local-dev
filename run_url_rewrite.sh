#!/bin/bash
printf "loading data in to container...\n"
docker cp rewrite_urls.sql docker_mariadb_1:/

printf "rewriting urls...\n"
docker exec docker_mariadb_1 /bin/sh -c 'mysql -u root -proot demo_db </rewrite_urls.sql'

printf "done!\n"
