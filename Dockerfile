FROM docker:dind

RUN apk add git
RUN apk add pwgen

RUN git clone https://github.com/spantaleev/matrix-docker-ansible-deploy.git

RUN wget https://raw.githubusercontent.com/EmilAminy/matrix-settings/main/vars.yml
RUN sed -i "s/<create_secretkey1>/$(pwgen -s 64 1)/g" vars.yml
RUN sed -i "s/<create_secretkey2>/$(pwgen -s 64 1)/g" vars.yml
RUN sed -i "s/<create_secretkey3>/$(pwgen -s 64 1)/g" vars.yml

RUN wget https://raw.githubusercontent.com/EmilAminy/matrix-settings/main/hosts.yml

RUN wget https://raw.githubusercontent.com/EmilAminy/matrix-settings/main/entrypoint.sh
RUN chmod u+x entrypoint.sh

WORKDIR /matrix-docker-ansible-deploy

ENTRYPOINT [ "/entrypoint.sh" ]
