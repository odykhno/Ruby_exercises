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
  @result = $pr_tr.include? @word
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

post '/save' do
  @filename = params[:filename]
  $pr_tr.save_to_file @filename
  erb :save
end

get '/load' do
  @filename = params[:filename]
  @output = $pr_tr.load_from_file @filename
  @output = @output[1, @output.size-2]
  @output = @output.split(",")
  erb :load
end

post '/save_zip' do
  @filename = params[:filename]
  $pr_tr.save_to_zip_file @filename
  @error = $pr_tr.zip_file_error
  erb :save_zip
end

get '/load_zip' do
  @filename = params[:filename]
  @output = $pr_tr.load_from_zip_file @filename
  @error = $pr_tr.zip_file_error
  unless @error
    @output = @output[1, @output.size-2]
    @output = @output.split(",")
  end
  erb :load_zip
end