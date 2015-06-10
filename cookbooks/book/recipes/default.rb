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
users_templ = node[:book][:users]
ssh_key = 
users_templ.each do |new_user|
    user new_user[:username] do
        action :create
        password new_user[:password]
        uid new_user[:uid]
        gid new_user[:gid]
        comment new_user[:comment]
        home new_user[:home_dir]
        shell new_user[:def_shell]
    end
    #Creating ssh-key
    user = new_user[:username]
    directory "/home/#{user}/.ssh" do
        owner new_user[:uid]
        group new_user[:gid]
        mode 0755
        action :create
    end
    file "/home/#{user}/.ssh/id_rsa.pub" do
        content new_user[:ssh_key]
        owner new_user[:uid]
        group new_user[:gid]
        mode 0755
        action :create
    end 
    file "/home/#{user}/.ssh/authorized_keys" do
        content new_user[:ssh_key]
        owner new_user[:uid]
        group new_user[:gid]
        mode 0755
        action :create
    end

end        
