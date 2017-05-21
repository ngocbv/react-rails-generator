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
