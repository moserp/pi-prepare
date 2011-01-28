require 'common'

policy :ubuntu, :roles => :app do
  requires :mtu
  requires :hostname
  requires :apt_sources
  requires :chef_client
  requires :chef_client_config
end

package :chef_client do
  gem 'chef'
  requires :ruby
  requires :rubygems
end

package :ruby do
  apt %w(ruby ruby-dev libopenssl-ruby rdoc ri irb build-essential wget ssl-cert git-core)
end

package :apt_sources do
  push_text 'deb http://gb.archive.ubuntu.com/ubuntu/ lucid universe', '/etc/apt/sources.list'
  push_text 'deb-src http://gb.archive.ubuntu.com/ubuntu/ lucid universe', '/etc/apt/sources.list'
  push_text 'deb http://gb.archive.ubuntu.com/ubuntu/ lucid-updates universe', '/etc/apt/sources.list'
  push_text 'deb-src http://gb.archive.ubuntu.com/ubuntu/ lucid-updates universe', '/etc/apt/sources.list'
  noop do
    post :install, 'apt-get update'
  end
end

deployment do
  delivery :capistrano do
    set :user, 'root'
    role :app, '109.144.14.xx', :primary => true
    default_run_options[:pty] = true
  end
  # source based package installer defaults
  source do
    prefix   '/usr/local'           # where all source packages will be configured to install
    archives '/usr/local/sources'   # where all source packages will be downloaded to
    builds   '/usr/local/build'     # where all source packages will be built
  end
end
