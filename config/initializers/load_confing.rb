require 'yaml'
config = File.open('../config.yml')

YAML::load_documents(config) do |conf|
  ALLOWED_HOSTNAMES = conf['allowed_hostnames']
  USERNAME  = conf['username']
  PASSWORD  = conf['password']
end
