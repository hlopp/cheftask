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
execute "unzip_tomcat" do
   command "unzip /tmp/#{jboss_name}.zip -d #{jboss_home}"
   creates "#{jboss_home}/#{jboss_name}"
end
