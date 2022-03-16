# change sources list

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo sed -i 's|http.*archive.ubuntu.com|http://mirrors.aliyun.com|g' /etc/apt/sources.list
sudo sed -i 's|http.*security.ubuntu.com|http://mirrors.aliyun.com|g' /etc/apt/sources.list
sudo sed -i 's|# d|d|g' /etc/apt/sources.list
sudo apt update
# sudo apt upgrade -y


# install docker
# curl -s "https://get.docker.com" | sh

# step 1: 安装必要的一些系统工具
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
# step 2: 安装GPG证书
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# Step 3: 写入软件源信息
sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
# Step 4: 更新并安装Docker-CE
sudo apt-get -y update
sudo apt-get -y install docker-ce

# docker version


# setup rootless
sudo apt-get install -y uidmap

dockerd-rootless-setuptool.sh install

# echo "\
# export PATH=/usr/bin:$PATH
# export DOCKER_HOST=unix:///run/user/1000/docker.sock " >> ~/.bashrc

# install docker-compose
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
sudo mkdir -p $DOCKER_CONFIG/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
sudo chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
sudo ln -s $DOCKER_CONFIG/cli-plugins/docker-compose /usr/bin/docker-compose

# sudo docker info

#
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo echo "\
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://127.0.0.1:2375
" >> docker.service.conf
sudo cp docker.service.conf /etc/systemd/system/docker.service.d/override.conf
sudo rm -f docker.service.conf

sudo systemctl daemon-reload
sudo systemctl restart docker.service

# sudo apt-get -y install net-tools
# sudo netstat -lntp | grep dockerd

#
curl -s "https://laravel.build/example-app?with=mysql,redis,selenium" | sudo bash
# cd example-app && sudo ./vendor/bin/sail up

cd example-app 

docker run --rm \
    -u "$(id -u):$(id -g)" \
    -v $(pwd):/var/www/html \
    -w /var/www/html \
    laravelsail/php81-composer:latest \
    composer install --ignore-platform-reqs

# sudo vendor/bin/sail up