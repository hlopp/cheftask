#Installing httpd
yum_package 'httpd' do
	action :install
end

execute "add_httpd_chkconfig" do
	command "chkconfig httpd on"
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
