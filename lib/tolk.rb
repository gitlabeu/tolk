module Tolk
end

# load local config file, is there any better place, somehow it didn't work on init.rb
require 'yaml'
config_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'config.yml'))
config = File.open(config_path)

YAML::load_documents(config) do |conf|
  ALLOWED_HOSTNAMES = conf['allowed_hostnames']
  USERNAME  = conf['username']
  PASSWORD  = conf['password']
end
