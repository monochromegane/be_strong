$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'be_strong'

require File.join(File.dirname(__FILE__), "dummy_app.rb")

RSpec.configure do |config|
  config.before :all do
    CreateTables.up if !ActiveRecord::Base.connection.table_exists?('authors')
  end
end
