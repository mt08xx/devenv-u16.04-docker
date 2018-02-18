# -*- mode: ruby -*-
# vi: set ft=ruby :
# https://qiita.com/mt08/items/5899ac04a88c60c12eb5
#
# - Open Git-Bash
# export VAGRANT_PREFER_SYSTEM_BIN=1
# vagrant up && vagrant reload

VM_NAME="devenv-u16.04-docker"
VM_MEMORY=2048
VM_CORES=2
VM_BOX="ubuntu/xenial64"

Vagrant.configure("2") do |config|
  config.vm.box = VM_BOX
  #config.vm.box_check_update = false

  #plugin: vagrant-vbguest 
  config.vbguest.auto_update = false

  # forwarded port (public)
  config.vm.network "forwarded_port", guest: 80  , host: 80   # http
  config.vm.network "forwarded_port", guest: 443 , host: 443  # https
  config.vm.network "forwarded_port", guest: 8080, host: 8080 # for phpMyAdmin
  config.vm.network "forwarded_port", guest: 3306, host: 3306 # MySQL

  # forwarded port (only for 'host_ip')
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Host-only network
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Bridged network
  # config.vm.network "public_network"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
    vb.name = VM_NAME
    vb.cpus = VM_CORES
    vb.memory = VM_MEMORY
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo `cat /proc/uptime | cut -f 1 -d ' '`  apt update
    # # apt cache server 
    # echo 'Acquire::http::Proxy "http://apt-cache-server:3142";' | sudo tee /etc/apt/apt.conf.d/02proxy
    apt-get -q update -q
    DEBIAN_FRONTEND=noninteractive apt-get -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
    apt-get install -y curl jq bash-completion pv htop
    #
    # Passwordでも、ssh接続できる.
    sed -i -e 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    systemctl restart sshd     
    #
    # Install: docker-ce
    echo `cat /proc/uptime | cut -f 1 -d ' '`  Installing: docker
    if [ ! -f /usr/bin/docker ]; then sh -c 'curl -sSL https://get.docker.com/ | sh'; fi 
    # Install: docker-compose
    echo `cat /proc/uptime | cut -f 1 -d ' '`  Installing: docker-compose
    DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r ".tag_name")
    curl -sL https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
    curl -sL https://raw.githubusercontent.com/docker/compose/${DOCKER_COMPOSE_VERSION}/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
    docker-compose --version
  SHELL

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    sudo usermod -aG docker ${USER}
  SHELL
end