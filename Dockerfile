FROM ubuntu:20.04
COPY timezone localtime /etc/
COPY setup_14.sh /
RUN apt update && apt -y install vim curl wget gcc && apt -y install software-properties-common 
RUN sh /setup_14.sh
RUN apt -y install nodejs
RUN npm install -g --unsafe-perm node-red
RUN apt -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev \
                 python python3 python3-pip influxdb influxdb-client git
COPY settings.js /usr/lib/node_modules/node-red/settings.js
RUN mkdir -p /data/nodes \
         /root/.ssh
EXPOSE 1880
ENV NODE_RED_ENABLE_PROJECTS="true"
RUN ssh-keyscan github.com > /root/.ssh/known_hosts
CMD [ "node-red" ]