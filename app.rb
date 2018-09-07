require 'sinatra'
require 'erb'
require './product'
require './database.rb'

class ProductApp < Sinatra::Base
    
    set :static, true
    set :views, "views"
    set :method_override, true


    #instanciate Product
    if ENV['RACK_ENV'] == 'test'
        Product.new()
        Product.connect(Database.test,String: "name", Float: "price")
    elsif ENV['RACK_ENV'] == 'development'
        Product.new()
        Product.connect(Database.dev,String: "name", Float: "price")
    end
    
    
    get '/' do 
        erb :welcome
        
    end
    
    
    get '/products' do
        @products = Product.all
        erb :index
    end
    
    get '/products/new' do 
        erb :form_new
    end
    
    get '/products/:id' do
        @product = Product.find(params[:id])
        if @product
            erb :show
        else
            halt 404, "Product Not Found"
        end
    end
    
    get '/products/:id/edit' do
        @product = Product.find(params[:id])
        if @product    
            erb :form_edit
        else
            halt 404, "Product Not Found"
        end
    end
    
    
    post '/products' do
        @product = Product.create(params)
        redirect to "/products/#{@product[:id]}"
    end
    
    post '/products/:id' do
        @product = Product.find(params[:id])
        Product.update(params[:id],params)
        redirect to "/products/#{@product[:id]}" 
    end
    
    get '/products/:id/delete' do
        @product = Product.find(params[:id])
        erb :delete
    end
    
    delete '/products/:id' do 
        @product = Product.find(params[:id])
        Product.delete(params[:id])
        redirect to '/products'
    end

end

