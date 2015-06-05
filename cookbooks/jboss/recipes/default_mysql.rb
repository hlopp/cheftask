#Installing mysql
yum_package "mysql-server" do
	action :install
end

execute "add_mysql_chkconfig" do
	command "chkconfig mysqld on"
end
