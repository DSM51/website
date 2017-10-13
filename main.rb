# encoding: utf-8

require 'sinatra'
require 'haml'
require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

require './asm8051'

class HTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end





before do
  cache_control :public, :must_revalidate, max_age: 60 if settings.production?
end

not_found do
  redirect to('/')
end

get '/highlighting.css' do
  content_type 'text/css'
  Rouge::Themes::Github.render(:scope => '.highlight')
end

helpers do
  def markdown(content)
    @parser ||= Redcarpet::Markdown.new(HTML.new, { fenced_code_blocks: true })
    @parser.render(content).chomp
  end

  def markdown_file(name)
    path = File.join 'posts', name + '.md'
    markdown File.read path
  end

  def markdown_file_exits?(name)
    path = File.join 'posts', name + '.md'
    File.exists? path
  end
end

#
#
#

get '/' do
  @content = markdown_file 'index'
  haml :post
end

get '/p/:name' do |name|
  halt 404 unless markdown_file_exits? name
  @content = markdown_file name
  haml :post
end
