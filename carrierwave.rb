# frozen_string_literal: true

# ruby carrierwave.rb

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'dotenv'

  gem 'fog-google'

  gem 'carrierwave', '~> 2.0'
  gem 'pry'
end

Dotenv.load

fog_creds = {
  provider: 'Google',
  google_project: ENV['GCS_PROJECT'],
  google_json_key_string: ENV['GCS_AUTH']
}

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = fog_creds
  config.fog_directory  = ENV['GCS_BUCKET']
  config.fog_public     = true
end

class Uploader < CarrierWave::Uploader::Base; end

file = File.new('rails.png')
upp = Uploader.new
upp.store!(file)
url = upp.url
puts url
puts `curl -I #{url}`
