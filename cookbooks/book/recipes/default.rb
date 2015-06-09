#
# Cookbook Name:: book
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


#Installing required packages
packages = node[:book][:packages]
packages.each do |pck|
    yum_package pck do
        action:install
    end
end

#Creating users
passwd_templ = node[:book][:users]
passwd_templ.each do |new_user|
    user new_user[:username] do
        action :create
        password new_user[:password]
        uid new_user[:uid]
        gid new_user[:gid]
        comment new_user[:comment]
        home new_user[:home_dir]
        shell new_user[:def_shell]
    end
end        
        
