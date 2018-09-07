# Small Product App #

This is a small product application. It is used to create and manage a Sqlite product table.

## Getting Started ##

To get the project up and running on the local machine and to test the project. Update the create_table function in all tests and app.rb file to suite your needs before running the app.#

## Prerequisites ##

The project uses ruby and a sqlite database

## Running Tests ##
Ensure that the create_table function is the same for all tests and app.rb file.

```ruby
Product.connect(Database.test,String: "name", Float: "price")
```

```bash
cd product_app
rspec 
```

## Run Application ##
```bash
rakeup config.ru
```
