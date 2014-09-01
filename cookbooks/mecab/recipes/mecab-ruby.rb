#
# Cookbook Name:: mecab
# Recipe:: mecab-ruby
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

version = node["mecab-rb"]["version"]
remote_file "#{Chef::Config[:file_cache_path]}/mecab-ruby-#{version}.tar.gz" do
  source "https://mecab.googlecode.com/files/mecab-ruby-#{version}.tar.gz"
  checksum node['mecab-rb']['checksum']
  mode "0644"
  not_if { ::File.exists?("/usr/local/lib/mecab/dic/mecab-ruby") }
end

bash "build_and_install_mecab-ruby" do
  user "root"
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -zxf mecab-ruby-#{version}.tar.gz
    (cd mecab-ruby-#{version} && ruby extconf.rb)
    (cd mecab-ruby-#{version} && make && make install)
  EOH
  not_if { ::File.exists?("/usr/local/lib/mecab/dic/mecab-ruby") }
end
