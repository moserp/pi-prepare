package :mtu do
  noop do
    post :install, 'ifconfig eth0 mtu 1440'
  end
end

package :hostname do
  transfer 'set_hostname.sh', '/tmp/set_hostname.sh' do
    post :install, 'bash /tmp/set_hostname.sh && rm /tmp/set_hostname.sh'
  end
end

package :chef_client_config do
  runner 'mkdir -p /etc/chef'
  transfer 'client.rb', '/etc/chef/client.rb'
  transfer 'validation.pem', '/etc/chef/validation.pem'
end
