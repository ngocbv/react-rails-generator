require "fileutils"

class InitReact
  def initialize app_name
    @app_name = app_name
    FileUtils::mkdir_p "#{@app_name}/app/jsx"
  end

  def init
    create_babelrc
    add_gitignore
    create_app_jsx
    create_bootstrap_jsx
    add_react_wrapper
    create_package_json
    create_webpack_config

    create_react_controller
    create_react_view
    add_to_routes
    init_api
  end

  def create_babelrc
    file_path = File.join(File.dirname(__FILE__), "../templates/.babelrc")
    babelrc = File.read(file_path)

    File.open("#{@app_name}/.babelrc", "w") do |f|
      f.write(babelrc)
    end
  end

  def add_gitignore
    gitignore = <<-HEREDOC
node_modules
app/assets/javascripts/react-app.js
HEREDOC

    File.open("#{@app_name}/.gitignore", "a+") do |f|
      f.write(gitignore)
    end
  end

  def create_app_jsx
    file_path = File.join(File.dirname(__FILE__), "../templates/jsx/app.jsx")
    app_jsx = File.read(file_path)

    File.open("#{@app_name}/app/jsx/app.jsx", "w") do |f|
      f.write(app_jsx)
    end
  end

  def create_bootstrap_jsx
    file_path = File.join(File.dirname(__FILE__), "../templates/jsx/bootstrap.jsx")
    bootstrap_jsx = File.read(file_path)

    File.open("#{@app_name}/app/jsx/bootstrap.jsx", "w") do |f|
      f.write(bootstrap_jsx)
    end
  end

  def add_react_wrapper
    file_name = "#{@app_name}/app/views/layouts/application.html.erb"
    text = File.read(file_name)
    new_contents = text.gsub(/<%= yield %>/, '<div id="react-wrapper"></div>')
    File.open(file_name, "w") {|f| f.write(new_contents)}
  end

  def create_package_json
    file_path = File.join(File.dirname(__FILE__), "../templates/package.json")
    package_json = File.read(file_path)

    File.open("#{@app_name}/package.json", "w") do |f|
      f.write(package_json)
    end
  end

  def create_webpack_config
    file_path = File.join(File.dirname(__FILE__), "../templates/webpack.config.js")
    webpack_config = File.read(file_path)

    File.open("#{@app_name}/webpack.config.js", "w") do |f|
      f.write(webpack_config)
    end
  end

  def create_react_controller
    file_path = File.join(File.dirname(__FILE__), "../templates/controllers/react_app_controller.rb")
    controller = File.read(file_path)

    File.open("#{@app_name}/app/controllers/react_app_controller.rb", "w") do |f|
      f.write(controller)
    end
  end

  def create_react_view
    FileUtils::mkdir_p "#{@app_name}/app/views/react_app"
    File.open("#{@app_name}/app/views/react_app/home.html.erb", "w")
  end

  def add_to_routes
    route = <<-HEREDOC
  root "react_app#home"
  get "*path", to: "react_app#home"
HEREDOC

    routes = File.readlines("#{@app_name}/config/routes.rb")
    i = routes.length
    while i > 1 do
      routes[i] = routes[i-1]
      i -= 1
    end
    routes[1] = route
    File.open("#{@app_name}/config/routes.rb", "w") do |f|
      f.write(routes.join)
    end
  end

  def init_api
    FileUtils::mkdir_p "#{@app_name}/app/jsx/CallAPI"

    base_api_path = File.join(File.dirname(__FILE__), "../templates/jsx/CallAPI/BaseAPI.js")
    base_api = File.read(base_api_path)
    File.open("#{@app_name}/app/jsx/CallAPI/BaseAPI.js", "w") do |f|
      f.write(base_api)
    end

    index_api_path = File.join(File.dirname(__FILE__), "../templates/jsx/CallAPI/index.jsx")
    index_api = File.read(index_api_path)
    File.open("#{@app_name}/app/jsx/CallAPI/index.jsx", "w") do |f|
      f.write(index_api)
    end

    FileUtils::mkdir_p "#{@app_name}/app/controllers/api"
    api_controller_path = File.join(File.dirname(__FILE__), "../templates/controllers/api/base_api_controller.rb")
    api_controller = File.read(api_controller_path)
    File.open("#{@app_name}/app/controllers/api/base_api_controller.rb", "w") do |f|
      f.write(api_controller)
    end
  end
end
