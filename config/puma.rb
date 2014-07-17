threads 6, 6
workers 4
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    cwd = File.dirname(__FILE__) + '/..'
    ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
    ActiveRecord::Base.establish_connection(
      ENV['DATABASE_URL'] ||
      YAML.load_file("#{cwd}/config/database.yml")[ENV['RAILS_ENV']]
    )
  end
end
