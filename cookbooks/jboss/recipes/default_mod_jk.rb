modjk_url = node['httpd']['mod_jk']['url']
modjk_name = node['httpd']['mod_jk']['name']

yum_package 'httpd-devel' do
        action :install
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


template  "/etc/httpd/conf.d/modjk.conf" do
        source "modjk.conf.erb"
        mode "0755"
        group "root"
        owner "root"
        action :create_if_missing
end

template "/etc/httpd/conf/workers.properties" do
	source "workers.properties.erb"
	mode "0755"
	group "root"
	owner "root"
	action :create_if_missing
end
