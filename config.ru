require 'blog_app'

if ENV['RACK_ENV'] == 'development' then
  log = File.new("tmp/log/sinatra.log", "a")
  STDOUT.reopen(log)
  STDERR.reopen(log)
end

run Sinatra::Application
