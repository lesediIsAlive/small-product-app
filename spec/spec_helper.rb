# spec/spec_helper.rb
ENV['RACK_ENV'] = 'test'
require 'bundler/setup'
require 'sinatra'
require 'rspec'
require_relative File.join('..', 'app.rb')

RSpec.configure do |config|

  def app
    run ProductApp
  end
end