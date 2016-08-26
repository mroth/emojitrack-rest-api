require 'rack-cache'
require 'dalli'
require 'memcachier'

# Defined in ENV on Heroku. To try locally, start memcached and uncomment:
# ENV["MEMCACHIER_SERVERS"] = "localhost"
if memcache_servers = ENV["MEMCACHIER_SERVERS"]
  use Rack::Cache,
    verbose: true,
    metastore:   "memcached://#{memcache_servers}",
    entitystore: "memcached://#{memcache_servers}"
end

$stdout.sync = true

# deflate output for bandwidth savings
use Rack::Deflater


require "./lib/config"
require "./web_api"
map('/api/v1/') { run WebAPI }
#TODO: load endpoints for old admin interface?
