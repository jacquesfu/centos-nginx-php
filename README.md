Centos with Nginx and PHP Quick Setup
================

Quick setup script for installing nginx with php-fpm. Run this inside your project to test your application inside a clean virtual server. Best used in a base installation of Centos 6.5.

# Vagrant Instructions

* Copy `vagrantfile` and `nginxsetup.sh` to your project folder.
* Run `vagrant up`

# Bash Instructions

* Run `curl -s https://raw.githubusercontent.com/jacquesfu/vagrant-centos-nginx-php/master/nginxsetup.sh | bash /dev/stdin arg1 arg2`

# TODO

* Create a single install command