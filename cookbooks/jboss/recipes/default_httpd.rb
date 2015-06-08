#Installing httpd
yum_package 'httpd' do
    action :install
end

execute "add_httpd_chkconfig" do
    command "chkconfig httpd on"
end

template "/etc/httpd/conf/httpd.conf" do
    source "httpd.conf.erb"
    mode "0755"
    group "root"
    owner "root"
    action :create
end

#Vhost file
template "/etc/httpd/conf.d/jboss.conf" do
    source "jboss.conf.erb"
    mode "0755"
    group "root"
    owner "root"
    action :create
end

service "httpd" do
    action :restart
end

