require 'rspec/core'
require './product'
require 'spec_helper'

RSpec.describe "Product" do

    before(:all) do
        
        Product.new()
        Product.connect(Database.test,String: "name",Float: "price")
    end



    it "created product table if it not already created" do

        expect(Product.all.count).to be_eql(0)

    end


    it "Products are created" do
        Product.create(name:"Once",price: 45.50)
        Product.create(name:"Twice",price: 90.90)
        Product.create(name:"Three Times",price: 135.5)

        expect(Product.all.count).to be_eql(3)

    end

    it "Products are deleted" do
        Product.delete(2)
        expect(Product.all.count).to be_eql(2)
    end

    it "product are updated" do
        Product.update(1,name:"Once again",price:33.4)
        product = Product.find(1)
        expect(product[:name]).to be_eql("Once again")
        expect(product[:price]).to be_eql(33.4)
    end

    after(:all) do
        Table.drop_table(Database.test)
    end


end