

# install docker
curl -s "https://get.docker.com" | sh

# setup rootless
sudo apt-get install -y uidmap

dockerd-rootless-setuptool.sh install

echo "\
export PATH=/usr/bin:$PATH \
export DOCKER_HOST=unix:///run/user/1000/docker.sock " >> ~/.bashrc

# install docker-compose
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker} && \
mkdir -p $DOCKER_CONFIG/cli-plugins && \
curl -SL https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose && \
sudo chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose && \
sudo ln -s $DOCKER_CONFIG/cli-plugins/docker-compose /usr/bin/docker-compose