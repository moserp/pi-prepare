require 'common'

policy :centos, :roles => :app do
  requires :mtu
  requires :yum_sources
end

package :yum_sources do
  transfer 'CentOS-Base.repo', '/etc/yum.repos.d/CentOS-Base.repo'
end

deployment do
  delivery :capistrano do
    set :user, 'root'
    role :app, '109.144.14.xx', :primary => true
    default_run_options[:pty] = true
  end
end
