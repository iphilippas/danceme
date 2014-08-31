#spec/spec_helper.

ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
Bundler.require(:default)

require File.expand_path('../app.rb', File.dirname(__FILE__))

require 'rspec'
require 'capybara/rspec'

Capybara.app = DanceMe::App




