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
template "etc/init.d/jboss" do
    source "jboss.erb"
    mode "0755"
    group "root"
    owner "root"
    action :create_if_missing
end


service "jboss" do
    action :start 
end


include_recipe 'jboss::default_httpd'
include_recipe 'jboss::default_mod_jk'
include_recipe 'jboss::default_mysql'
