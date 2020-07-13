require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'recipe'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  # 'Salut le monde !'
  # '<h1>Hello <em>world</em>!</h1>'
  @recipes = Cookbook.new('recipes.csv').all
  erb :index
end

get '/about' do
  erb :about
end

get '/team/:username' do
  # binding.pry
  puts params[:username]
  "The username is #{params[:username]}"
end

get '/new' do
  @name = params["recipe-name"]
  @description = params["recipe-description"]
  @prep_time = params["recipe-preptime"]
  @difficulty = params["recipe-difficulty"]
  erb :new
end

post '/recipes' do
  @name = params["recipe-name"]
  @description = params["recipe-description"]
  @prep_time = params["recipe-preptime"]
  @difficulty = params["recipe-difficulty"]
  recipe = Recipe.new(@name, @description, @prep_time, false, @difficulty)
  @recipes = Cookbook.new('recipes.csv').add(recipe)
  '<h1>Recipe added!</h1>
  <a href="/"> Go back to your Cookbook!</a>'
end

post '/remove' do
  # binding.pry
  @index = params[:index].to_i
  @recipes = Cookbook.new('recipes.csv').remove_at(@index)
  '<h1> Recipe removed</h1>
  <a href="/"> Go back to your Cookbook!</a>'
end
