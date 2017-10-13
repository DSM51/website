# encoding: utf-8

require 'sinatra'
require 'haml'

before do
  cache_control :public, :must_revalidate, max_age: 60 if settings.production?
end

get '/' do
  haml :main
end
