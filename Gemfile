source 'https://rubygems.org'

# Specify your gem's dependencies in rosebud.gemspec
gemspec

rails_version = case ENV['RAILS_VERSION'] || 'default'
when 'master'
  { git: 'https://github.com/rails/rails.git' }
when 'default'
  '~> 4.0'
else
  "~> #{ENV['RAILS_VERSION']}"
end

gem 'rails', rails_version

platforms :ruby do
  gem 'sqlite3'
end

platforms :jruby do
  gem 'activerecord-jdbcsqlite3-adapter'
end

platforms :rbx do
  gem 'racc'
  gem 'rubinius-coverage', github: 'rubinius/rubinius-coverage'
  gem 'rubysl'
end

group :development do
  #gem 'coveralls', require: false
end