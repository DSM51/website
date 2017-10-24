# encoding: utf-8

require 'sinatra'
require "sinatra/content_for"
require 'haml'

#

not_found do
  redirect to('/')
end


#
#
#

get '/' do
  redirect to('/pages')
end

get '/pages' do
  haml :pages
end

get '/p/:name' do |name|
  haml :"posts/#{name}"
end
