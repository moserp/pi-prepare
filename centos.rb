require 'common'

policy :centos, :roles => :app do
  requires :mtu
  requires :hostname
  requires :yum_sources
  requires :chef_client
  requires :chef_client_config
end

package :yum_sources do
  transfer 'CentOS-Base.repo', '/etc/yum.repos.d/CentOS-Base.repo'
end

package :chef_client do
  gem 'chef'
  requires :ruby
  requires :rubygems
  requires :make
end

package :ruby do
  yum %w(ruby ruby-shadow ruby-ri ruby-rdoc ruby-devel ruby-static)
  requires :gcc
  requires :epel
  requires :elff
end

package :make do
  yum 'make'
end

package :gcc do
  yum %w(gcc gcc-c++)
end

package :epel do
  rpm 'http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-4.noarch.rpm'
end

package :elff do
  rpm 'http://download.elff.bravenet.com/5/i386/elff-release-5-3.noarch.rpm'
end

deployment do
  delivery :capistrano do
    set :user, 'root'
    role :app, '109.144.14.27', :primary => true
    default_run_options[:pty] = true
  end
  # source based package installer defaults
  source do
    prefix   '/usr/local'           # where all source packages will be configured to install
    archives '/usr/local/sources'   # where all source packages will be downloaded to
    builds   '/usr/local/build'     # where all source packages will be built
  end
end
