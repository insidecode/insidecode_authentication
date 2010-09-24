Rails::Generator::Commands::Create.class_eval do
  def route_resource(*resources)
    resource_list = resources.map { |r| r.to_sym.inspect }.join(', ')
    sentinel = 'Application.routes.draw do'

    logger.route "resources #{resource_list}"
    unless options[:pretend]
      gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
        "#{match}\n  resource :#{resource_list}\n"
      end
    end
  end
  
  def route_name(name, path, route_options = {})
    sentinel = 'ActionController::Routing::Routes.draw do |map|'
    
    logger.route "match \"#{name}\" => \"#{path}\""
    unless options[:pretend]
      gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
        "#{match}\n  match \"#{name}\" => \"#{path}\""
      end
    end
  end
end

Rails::Generator::Commands::Destroy.class_eval do
  def route_resource(*resources)
    resource_list = resources.map { |r| r.to_sym.inspect }.join(', ')
    look_for = "\n  resource :#{resource_list}\n"
    logger.route "resource: #{resource_list}"
    unless options[:pretend]
      gsub_file 'config/routes.rb', /(#{look_for})/mi, ''
    end
  end
  
  def route_name(name, path, route_options = {})
    look_for =   "\n  match \"#{name}\" => \"#{path}\""
    logger.route "match \"#{name}\" => \"#{path}\""
    unless options[:pretend]
      gsub_file    'config/routes.rb', /(#{look_for})/mi, ''
    end
  end
end

Rails::Generator::Commands::List.class_eval do
  def route_resource(*resources)
    resource_list = resources.map { |r| r.to_sym.inspect }.join(', ')
    logger.route "resource :#{resource_list}"
  end
  
  def route_name(name, path, options = {})
    logger.route "match \"#{name}\" => \"#{path}\""
  end
end