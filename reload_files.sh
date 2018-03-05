#!/bin/bash

docker-compose -f docker/docker-compose.yml down
docker image rm -f test-site
docker volume rm -f docker_demo_site
docker image prune -f
docker volume prune -f
docker-compose -f docker/docker-compose.yml up -d

printf "Setting File Permissions...\n"
docker exec docker_test-site_1 /bin/sh -c 'chown -R www-data:www-data /var/www/html'

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

