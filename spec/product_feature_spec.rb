require('capybara/rspec')
require 'capybara/dsl'
require 'rspec'
require "spec_helper"
require "./product"
require('./app')


Capybara.app = ProductApp


    before(:all) do
        Product.new
        Product.connect(Database.test,String: "name", Float: "price")

    end




RSpec.describe "Product Features",{type: :feature} do
    it "A user can list products" do
        visit('/')
        
        click_on "List Products"
        expect(page).to have_content("All Products")
    end

    it "A user can create a product" do
        visit('/products/new')
        fill_in "name", with: "Product One"
        fill_in "price", with: 35.50
        click_button 
        expect(page).to have_content("Product One")
        expect(page).to have_content("35.5")

    end

    it "A user updated a product" do
        product = Product.create(name:"Product Two",price:40)
        visit("/products/#{product[:id]}")
        click_link "Update Product"
        fill_in "name", with: "Product Three"
        fill_in "price", with: 35.50
        click_button
        expect(page).to have_content("Product Three")
        expect(page).to have_content(35.50)
    end

    it "User deletes product" do
        product1 = Product.create(name:"Product Four",price: 60)
        visit("/products")
        click_link "Product Four"
        click_link "Delete Product"
        click_button "Delete Product?"
        expect(page).not_to have_content("Product Four")
    end

    after(:all) do 
        Table.drop_table(Database.test)
    end



end