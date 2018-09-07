require './product'
require 'sequel'
require 'sqlite3'

module Database

    def Database.dev()
        Sequel.connect('sqlite://db//product_dev.db')
    end


    def Database.test()
        Sequel.connect('sqlite://db//product_test.db')
    end
end

module Table

    def Table.create_table(database,args)
        if database.tables.include?(:products)    
                table = database[:products]
        else
            database.run(create_query(args))
            table = database[:products]
        end
        table
    end

    def Table.drop_table(database)
        database.drop_table(:products)
    end

    def Table.create_query(args)
        parameters = ""
        args.each do |arg|
            parameters += "#{arg[1]} #{arg[0]}, "
        end
        parameters = parameters[0,parameters.size-2]
        query = "CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT," + parameters + ")"
    end

end

