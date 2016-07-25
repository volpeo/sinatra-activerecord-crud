require_relative "config/application"
require_relative "models/restaurant"
require "sinatra"
# require "sinatra/reloader"
require "sinatra/activerecord"


get "/" do
  @restaurants = Restaurant.all
  erb :restaurants
end

get "/restaurants/new" do
  erb :new
end

get '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  erb :restaurant
end

post "/restaurants" do
  new_restaurant = Restaurant.create(params)
  redirect "/restaurants/#{new_restaurant.id}"
end

get "/restaurants/:id/delete" do
  Restaurant.find(params[:id]).destroy
  redirect "/"
end

get "/restaurants/:id/edit" do
  @restaurant = Restaurant.find(params[:id])
  erb :edit
end

post "/restaurants/:id" do
  restaurant = Restaurant.find(params[:id])
  restaurant.name = params[:name]
  restaurant.address = params[:address]
  restaurant.rating = params[:rating]
  restaurant.save
  redirect "/restaurants/#{restaurant.id}"
end
