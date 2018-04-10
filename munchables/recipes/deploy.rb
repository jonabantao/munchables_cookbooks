service "munchables" do
  action [:stop]
end 

directory "#{node[:munchables][:path]}" do
  owner 'ubuntu'
  group 'ubuntu'
  mode '0755'
  recursive true
  action :create
end

# deploy script here
git "#{node[:munchables][:path]}" do
  repository node[:munchables][:git_repository]
  revision node[:munchables][:git_revision]
  environment ({"HOME"=>"/home/ubuntu"})
  action :sync
  user "ubuntu"
end

execute "Install Gems" do
  cwd node[:munchables][:path]
  command "bundle install"
  user "ubuntu"
  # group new_resource.group
  environment ({"HOME"=>"/home/ubuntu"})
  # not_if { package_installed? }
end

execute "Install NPM packages" do
  cwd node[:munchables][:path]
  command "npm install"
  user "ubuntu"
  # group new_resource.group
  environment ({"HOME"=>"/home/ubuntu"})
  # not_if { package_installed? }
end

execute "Compile Webpack Assets" do
  cwd node[:munchables][:path]
  command "./node_modules/.bin/webpack"
  environment ({"NODE_ENV": "production", "HOME": "/home/ubuntu"})
  user "ubuntu"
end

execute "Clobber Rails Assets" do
  cwd node[:munchables][:path]
  command "bundle exec rake assets:clobber"
  environment ({"RAILS_ENV": "production", "HOME": "/home/ubuntu"})
  user "ubuntu"
end

execute "Compile Rails Assets" do
  cwd node[:munchables][:path]
  command "bundle exec rake assets:precompile"
  environment ({"RAILS_ENV": "production", "HOME": "/home/ubuntu"})
  user "ubuntu"
end

service "munchables" do
  action [ :enable, :start ]
end 