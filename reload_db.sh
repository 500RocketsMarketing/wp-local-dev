#!/bin/bash

docker-compose -f docker/docker-compose.yml down
docker volume rm -f docker_demodb
docker volume prune -f
docker-compose -f docker/docker-compose.yml up -d

timeout=$((SECONDS+30))
check_mysql() {
	docker exec docker_mariadb_1 /bin/sh -c 'mysql -u root -proot demo_db && echo "pass" || echo "fail"'
}

until [ "$(check_mysql)" == "pass" ] || [ "$SECONDS" -gt "$timeout" ]; do
    printf "Waiting for mysql to boot.....\n"
    sleep 2
done

if [ "$(check_mysql)" != "pass" ]; then 
  printf "mysql failed to boot!\n"
  exit 1
else
  printf "mysql booted!\n"
fi

printf "loading data in to container...\n"
docker cp initdata.sql docker_mariadb_1:/

printf "importing into database...\n"
docker exec docker_mariadb_1 /bin/sh -c 'mysql -u root -proot demo_db </initdata.sql'

timeout=$((SECONDS+30))
check_http() {
	curl -A "Web Check" -sL --connect-timeout 3 -w "%{http_code}\n" "http://127.0.0.1" -o /dev/null
}

until [ "$(check_http)" == "200" ] || [ "$SECONDS" -gt "$timeout" ]; do
    printf "Waiting for site to boot.....\n"
    sleep 2
done

if [ "$(check_http)" != "200" ]; then 
  printf "Site failed to boot!\n"
  exit 1
else
  printf "Site booted!\n"
  exit 0
fi

