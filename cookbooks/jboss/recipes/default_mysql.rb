connector_url = node['mysqld']['connector']['url']
connector_name = node['mysqld']['connector']['name']
jboss_home = node['jboss']['jboss_home']
jboss_name = node['jboss']['name']


#Installing mysql
yum_package "mysql-server" do
	action :install
end

execute "add_mysql_chkconfig" do
	command "chkconfig mysqld on"
end


#Preparing folder for mysql 
directory "#{jboss_home}/#{jboss_name}/modules/com/mysql/main" do
        action :create
end


#Downoading mysql connector and placing it to proper folder
remote_file "#{connector_name}.jar" do
        source connector_url
        path "#{jboss_home}/#{jboss_name}/modules/com/mysql/main/#{connector_name}.jar"
        action :create_if_missing
end


#Module related to mysql connector
template "#{jboss_home}/#{jboss_name}/modules/com/mysql/main/module.xml" do
    source "module.xml.erb"
    mode "0755"
    group "root"
    owner "root"
    action :create_if_missing
end


template "#{jboss_home}/#{jboss_name}/standalone/configuration/standalone-ha.xml" do
    source "standalone-ha.xml.erb"
    mode "0755"
    group "root"
    owner "root"
    action :create
end

