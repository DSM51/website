# encoding: utf-8

require 'sinatra'
require 'haml'

before do
  cache_control :public, :must_revalidate, max_age: 5*60
end

get '/' do
  haml :main
end
