$:<< "."

require 'rubygems' 
require 'bundler'  
Bundler.require
require 'rackspace-cloud-monitoring-hipchat'

use Rack::ShowExceptions
use Rack::MethodOverride

run RackspaceCloudMonitoringHipchat.new