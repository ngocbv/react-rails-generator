# React Rails generator

[![Gem Version](https://badge.fury.io/rb/react-rails-generator.svg)](https://badge.fury.io/rb/react-rails-generator)

A simple gem that make combine React and Rails easier

## Getting started
This gem create a Rails project combine with React (connect through API)

We can intall this gem by command
```
$ gem install react-rails-generator
```

First you need to create project with command
```
$ react-rails new <project_name>
```

After that we have to install the packages that declare in package.json
```
$ npm install
```

## Usage
We have to run rails and webpack to monitor
```
$ rails server
```
and
```
$ webpack --watch
```
And view the project works

## Contributing
We love pull requests. Here's a quick guide:
1. Fork the project
2. Comment these lines from Gem Specification
```
s.cert_chain  = ['certs/public_cert.pem']
s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/
```
3. To test your change
  - git add .
  - gem build react_rails.gemspec
  - gem install react-rails-generator-version.gem
4. Make the changes and push to your repository
5. Make a pull request
