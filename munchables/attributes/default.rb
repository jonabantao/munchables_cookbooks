default['ruby-ng']['ruby_version'] = "2.5"
default['nodejs']['version'] = "8.9.4"
default['nodejs']['npm']['version'] = "5.8.0"
default['nginx']['default_site_enabled'] = false

default[:munchables][:git_repository] = "https://github.com/jonabantao/munchables/"
default[:munchables][:git_revision] = "master"
default[:munchables][:path] = "/opt/jonabantao"

default[:munchables][:rails_env] = "production"
default[:munchables][:log_to_stdout] = "true"

default[:munchables][:environment] = {
  "SECRET_KEY_BASE": node[:munchables][:secret_key_base],
  "DATABASE_URL": node[:munchables][:database_url],
  "RAILS_ENV": node[:munchables][:rails_env],
  "RAILS_LOG_TO_STDOUT": node[:munchables][:log_to_stdout],
  "s3_access_key_id": node[:munchables][:s3_access_key_id],
  "s3_bucket": node[:munchables][:s3_bucket],
  "s3_region": node[:munchables][:s3_region],
  "s3_secret_access_key": node[:munchables][:s3_secret_access_key]
}

default[:munchables][:start_cmd] = "unicorn -E production -c /opt/unicorn.rb"