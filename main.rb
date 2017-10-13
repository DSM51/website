# encoding: utf-8

require 'sinatra'
require 'haml'


get '/' do
  haml :main
end
