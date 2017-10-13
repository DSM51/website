# encoding: utf-8

require 'sinatra'
require 'haml'
require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'


before do
  cache_control :public, :must_revalidate, max_age: 60 if settings.production?
end

get '/' do
  haml :main
end

class HTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end


get '/highlighting.css' do
  content_type 'text/css'
  Rouge::Themes::Github.render(:scope => '.highlight')
end

get '/p/:name' do |name|
  path = File.join 'posts', name + '.md'
  halt 404 unless File.exists? path
  content = File.read path
  renderer = HTML
  parser = Redcarpet::Markdown.new(renderer.new, { fenced_code_blocks: true })

  @content = parser.render(content).chomp

  haml :post
end
