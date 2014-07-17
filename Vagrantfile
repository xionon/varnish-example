# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "phusion/ubuntu-14.04-amd64"

  # Quick provisioning help
  # config.vm.provision "shell",
  #   inline: <<-EOT
  #     apt-get install git curl -y
  #     apt-get install apt-transport-https
  #     curl https://repo.varnish-cache.org/ubuntu/GPG-key.txt | apt-key add -
  #     echo "deb https://repo.varnish-cache.org/ubuntu/ precise varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list
  #     apt-get update
  #     apt-get install varnish
  #     echo "gem: --no-rdoc --no-ri" >> /etc/gemrc
  #     \\curl -sSL https://get.rvm.io | bash -s stable --rails
  #   EOT

  config.vm.network :private_network, ip: "192.168.0.0"
end
