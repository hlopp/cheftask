#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


jboss_home = node['jboss']['jboss_home'] 
jboss_url = node['jboss']['url']
jboss_name = node['jboss']['name']
modjk_url = node['httpd']['mod_jk']['url']
modjk_name = node['httpd']['mod_jk']['name']

#Installing unzip
yum_package 'unzip' do
	action :install
end

#Installing httpd
yum_package 'httpd' do
	action :install
end

execute "add_httpd_chkconfig" do
	command "chkconfig httpd on"
end


yum_package 'httpd-devel' do
        action :install
end


cookbook_file "jboss.conf" do
	path "/etc/httpd/conf.d/jboss.conf"
	mode "0755"
	group "root"
	owner "root"
	action :create_if_missing
end


#Installinf mysql
yum_package "mysql-server" do
	action :install
end

execute "add_mysql_chkconfig" do
	command "chkconfig mysqld on"
end


#Downoading jboss
remote_file "#{jboss_name}.zip" do
	source jboss_url
	path "/tmp/#{jboss_name}.zip"
	action :create_if_missing 
end 


#Preparing home folder for jboss
directory "#{jboss_home}" do
	action :create
end


#Unzipping jboss
execute "unzip_jboss" do
   command "unzip /tmp/#{jboss_name}.zip -d #{jboss_home}"
   creates "#{jboss_home}/#{jboss_name}"
end


#Creating init script for jboss
cookbook_file "jboss" do
	path "/etc/init.d/jboss"
	mode "0755"
	group "root"
	owner "root"
	action :create_if_missing
end

service "jboss" do
    action :start 
end

#Downloading mod_jk for apache
remote_file "#{modjk_name}.tar.gz" do
	source modjk_url
	path "/tmp/#{modjk_name}.tar.gz"
	action :create_if_missing 
end 

execute "extract mod_jk" do
  command "tar -xvf /tmp/#{modjk_name}.tar.gz"
end


bash "modjk_manipulations" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -xvf #{modjk_name}.tar.gz
    yum install gcc make automake libtool
    cd tomcat-connectors-1.2.40-src/native
    ./buildconf.sh
    ./configure --with-apxs=/usr/sbin/apxs
    make
    make install
  EOH
end


cookbook_file "modjk.conf" do
        path "/etc/httpd/conf.d/modjk.conf"
        mode "0755"
        group "root"
        owner "root"
        action :create_if_missing
end

cookbook_file "workers.properties" do
	path "/etc/httpd/conf/workers.properties"
	mode "0755"
	group "root"
	owner "root"
	action :create_if_missing
end

cookbook_file "httpd.conf" do
        path "/etc/httpd/conf/httpd.conf"
        mode "0755"
        group "root"
        owner "root"
        action :create_if_missing
end

service "httpd" do
  action :restart
end
