#
# Cookbook Name:: lemp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "yum-update" do
    command "yum update -y"
end
execute "get RHEL 6.x" do
    command "rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm"
end

packages = %w{
    git
    vim
    zsh
    httpd
    mod_ssl
    php54
    php54-pdo
    php54-common
    php54-xml
    php54-mysql
    php54-pgsql
    php54-curl
    php54-mcrypt
    php54-cli
    php54-fpm
    php54-pear
    php54-dom
    php54-soap
    php54-gd
    mysql
    mysql-server
    postgresql
    curl}

packages.each do |pkg|
    package pkg do
        action [:install, :upgrade]
    end
end

execute "phpunit-install" do
    command "pear config-set auto_discover 1; pear install pear.phpunit.de/PHPUnit"
    not_if { ::File.exists?("/usr/bin/phpunit")}
end

execute "composer-install" do
    command "curl -sS https://getcomposer.org/installer | php ;mv composer.phar /usr/local/bin/composer"
    not_if { ::File.exists?("/usr/local/bin/composer")}
end

%w{mysqld httpd}.each do |service_name|
    service service_name do
        action [:enable, :start]
        supports :status => true, :restart => true, :reload => true
    end
end
