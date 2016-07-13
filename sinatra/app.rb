require 'sinatra'
require '../lib/prefix_tree'

$pr_tr = PrefixTree.new

get '/' do
  erb :index
end

get '/back' do
  redirect '/'
end

post '/add' do
  @word = params[:word_add]
  $pr_tr.add @word
  erb :add
end

get '/include' do
  @word = params[:word_check]
  # $pr_tr.include? @word
  erb :include
end

get '/list' do
  @prefix = params[:prefix]
  if @prefix
    @output = $pr_tr.list @prefix
  else
    @output = $pr_tr.list
  end
  erb :list
end


