module BeStrong
  module Rails
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load 'be_strong/rails/tasks.rake'
      end
    end
  end
end
