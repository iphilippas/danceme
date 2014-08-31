require 'bundler/setup'
Bundler.require(:default)
require File.expand_path('app', File.dirname(__FILE__))

run DanceMe::App
