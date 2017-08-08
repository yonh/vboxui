# Set application dependencies
require File.expand_path("../app", __FILE__)


Dir.glob('./{class}/*.rb').each { |file|
  require file
}

set :port, 3380
set :bind, '0.0.0.0'
enable :sessions

App.run!
