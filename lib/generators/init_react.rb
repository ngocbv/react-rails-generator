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
    test_path = File.join(File.dirname(__FILE__), "../templates/test.txt")
    puts File.read(test_path)
  end

  def create_babelrc
    babelrc = <<-HEREDOC
{
  presets: [
    "es2017",
    "react",
  ],
  "plugins": [
    "transform-class-properties",
  ],
}
HEREDOC

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
    app_jsx = <<-HEREDOC
import getMuiTheme from "material-ui/styles/getMuiTheme";
import MuiThemeProvider from "material-ui/styles/MuiThemeProvider";

export default class App extends React.Component {
 render() {
   return (
     <MuiThemeProvider muiTheme={getMuiTheme()}>
       <mui.Drawer open={true}>
         <mui.MenuItem>FAQ</mui.MenuItem>
       </mui.Drawer>
     </MuiThemeProvider>
   );
 }
}
HEREDOC

    File.open("#{@app_name}/app/jsx/app.jsx", "w") do |f|
      f.write(app_jsx)
    end
  end

  def create_bootstrap_jsx
    bootstrap_jsx = <<-HEREDOC
import ReactDOM from "react-dom";
import {Router, Route, Link, browserHistory} from "react-router"

import injectTapEventPlugin from "react-tap-event-plugin";
injectTapEventPlugin();

import App from "./app";

const router = (
  <Router history={browserHistory}>
    <Route path="/" component={App}>
    </Route>
  </Router>
);

$(document).on("ready page:load", function() {
 ReactDOM.render(router, document.getElementById("react-wrapper"));
});
HEREDOC

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
    package_json = <<-HEREDOC
{
  "private": true,
  "dependencies": {
    "babel-core": "^6.18.2",
    "babel-loader": "^6.2.7",
    "babel-preset-es2017": "^1.4.0",
    "babel-preset-react-hmre": "^1.1.1",
    "babel-preset-react": "^6.16.0",
    "babel-plugin-add-module-exports": "~0.2.1",
    "babel-plugin-transform-class-properties": "~6.19.0",
    "material-ui": "^0.16.0",
    "react": "^15.4.0",
    "react-addons-update": "^15.4.0",
    "react-dom": "^15.4.0",
    "react-router": "^3.0.0",
    "react-tap-event-plugin": "^2.0.0",
    "react-toastr": "^2.8.0",
    "webpack": "~1.13.3"
  }
}
HEREDOC

    File.open("#{@app_name}/package.json", "w") do |f|
      f.write(package_json)
    end
  end

  def create_webpack_config
    webpack_config = <<-HEREDOC
var webpack = require("webpack");

const paths = {
  js: "./app/assets/javascripts/",
  jsx: "./app/jsx/",
}

var alias = {
  "react/lib/CSSPropertyOperations": "react-dom/lib/CSSPropertyOperations"
};

module.exports = {
  entry: paths.jsx + "bootstrap.jsx",
  output: {
    path: paths.js,
    filename: "react-app.js",
  },
  resolve: {
    extensions: ['', '.js', '.jsx'],
    alias: alias,
  },
  module: {
    loaders: [{
      test: /\.jsx?$/,
      loaders: ['babel?cacheDirectory'],
    }]
  },
  plugins: [
    new webpack.ProvidePlugin({
      React: "react",
      mui: "material-ui",
    })
  ],
}
HEREDOC

    File.open("#{@app_name}/webpack.config.js", "w") do |f|
      f.write(webpack_config)
    end
  end

  def create_react_controller
    controller = <<-HEREDOC
class ReactAppController < ApplicationController
  def home
  end
end
HEREDOC

    File.open("#{@app_name}/app/controllers/react_app_controller.rb", "w") do |f|
      f.write(controller)
    end
  end
end
