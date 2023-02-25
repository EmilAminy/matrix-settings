#!/bin/sh

mkdir /matrix-docker-ansible-deploy/inventory/host_vars/${MY_DOMAIN}
mv /vars.yml /matrix-docker-ansible-deploy/inventory/host_vars/${MY_DOMAIN}

sed -i "s/<your_domain>/${MY_DOMAIN}/g" /hosts.yml
mv /hosts.yml /matrix-docker-ansible-deploy/inventory

docker run -it --rm \
    -w /work \
    -v `pwd`:/work \
    -v $HOME/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
    --entrypoint=/bin/sh \
    docker.io/devture/ansible:2.13.6-r0-1

ansible-playbook -i inventory/hosts setup.yml \
    --extra-vars="username=${ADMIN_USERNAME} password=${ADMIN_PASSWORD} admin=yes" \
    --tags=register-user
