require "active_record"
require 'active_record/mass_assignment_security'
require 'action_controller/railtie'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

module DummyApp
  class Application < Rails::Application
    config.root = File.join(File.dirname(__FILE__), 'dummy_app')
  end
end
DummyApp::Application.initialize!

class NoAttrAccessible < ActiveRecord::Base
end

class Author < ActiveRecord::Base
  attr_accessible :name, :age
end

class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table(:authors) do |t|
      t.string :name
      t.integer :age
    end

    create_table(:no_attr_accessibles) do |t|
      t.string :column1
    end
  end
end
