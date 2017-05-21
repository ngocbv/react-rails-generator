Gem::Specification.new do |s|
  s.name        = 'react-rails-generator'
  s.version     = '0.1.0'
  s.executables << 'react-rails'
  s.date        = '2017-05-17'
  s.summary     = 'React Rails generator'
  s.description = 'A simple React Rails generator'
  s.authors     = ['Bach Van Ngoc']
  s.email       = 'nevesmile12b1@gmail.com'
  s.files       = `git ls-files lib`.split("\n")
  s.homepage    =
    'https://github.com/NeverSmileK57CLC/react-rails-generator'
  s.license       = 'MIT'
  # s.cert_chain  = ['certs/public_cert.pem']
  # s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/
end
