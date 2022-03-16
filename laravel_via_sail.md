# Initialize Laravel project with Sail

## Requirement

- Ubuntu-20.04

Or:

- Windows
- Vagrant
- Virtualbox

### Setup Ubuntu With Vagrant

```
vagrant init bento/ubuntu-20.04

vagrant up
```

## Setup Docker services

- install docker

```sh
curl -s "https://get.docker.com" | sh
```

- setup rootless

```sh
sudo apt-get install -y uidmap

dockerd-rootless-setuptool.sh install

echo "\
export PATH=/usr/bin:$PATH \
export DOCKER_HOST=unix:///run/user/1000/docker.sock " >> ~/.bashrc
```

- install docker-compose

```sh
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker} && \
mkdir -p $DOCKER_CONFIG/cli-plugins && \
curl -SL https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose && \
sudo chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose && \
sudo ln -s $DOCKER_CONFIG/cli-plugins/docker-compose /usr/bin/docker-compose
```

## Setup Laravel Sail

- setup 

```sh
curl -s "https://laravel.build/example-app?with=mysql,redis,selenium" | sudo bash
```

- start application

```sh
cd example-app && sudo ./vendor/bin/sail up
```