require 'common'

policy :ubuntu, :roles => :app do
  requires :mtu
  requires :apt_sources
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
end
