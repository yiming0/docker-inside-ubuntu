# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  ## 
  config.vm.define 'bento_ubuntu'

  ## 
  config.vm.box = "bento/ubuntu-20.04"

  ## 
  config.vm.network :forwarded_port, guest: 22, host: 2222, auto_correct: false, id: "ssh"

  ## 
  config.vm.network "private_network", ip: "192.168.56.10"

  ##
  config.vm.synced_folder "D:/workspace/code", "/home/vagrant/code"

  ## Configure The Public Key For SSH Access
  if File.exist? File.expand_path('~/.ssh/id_rsa.pub')
    config.vm.provision "setting authorize key", type: "shell" do |s|
      s.inline = "echo $1 | grep -xq \"$1\" /home/vagrant/.ssh/authorized_keys || echo \"\n$1\" | tee -a /home/vagrant/.ssh/authorized_keys"
      s.args = [File.read(File.expand_path('~/.ssh/id_rsa.pub'))]
    end
  end 

  ##
  
  confDir = $confDir ||= File.expand_path(File.dirname(__FILE__))
  installDockerScript = confDir + '/install-docker.sh'
  config.vm.provision "Run install-docker.sh", type: "shell", path: installDockerScript, privileged: false, keep_color: true

end
