require 'bundler'
Bundler.require
require_relative 'lib/scrapper'

$:.unshift File.expand_path("./../lib", __FILE__)
#require 'app/scrapper'
#require 'app/email_sender' pas necessaire ici

Scrapper.new.perform

