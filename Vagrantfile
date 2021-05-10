# -*- mode: ruby -*-
# vi: set ft=ruby :

# Based on https://github.com/samvera-deprecated/samvera-vagrant
# Updated and modified for CentOS

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.network :forwarded_port, guest: 3000, host: 3000 # Rails
  config.vm.network :forwarded_port, guest: 8983, host: 8983 # Solr
  config.vm.network :forwarded_port, guest: 8984, host: 8984 # Fedora

  config.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
  end

  config.vm.provision "shell", path: "./install-scripts/bootstrap.sh"
  config.vm.provision "shell", path: "./install-scripts/ruby.sh"
  config.vm.provision "shell", path: "./install-scripts/fits.sh"
  # @todo install ffmpeg
  config.vm.provision "shell", path: "./install-scripts/cuirator.sh"
  config.vm.provision "shell", path: "./install-scripts/bundle.sh", privileged: false 
end
