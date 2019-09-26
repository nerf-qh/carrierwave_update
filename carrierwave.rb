# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require

Dotenv.load

fog_creds = {
  provider: 'Google',
  google_project: ENV['GCS_PROJECT'],
  google_json_key_string: ENV['GCS_AUTH']
}

CarrierWave.configure do |config|
  config.fog_credentials = fog_creds
  config.fog_directory  = ENV['GCS_BUCKET']
  config.fog_public     = true
  config.storage = :fog
end

class Uploader < CarrierWave::Uploader::Base; end

file = File.new('rails.png')
upp = Uploader.new
upp.store!(file)
url = upp.url
puts url
puts `curl -I #{url}`
