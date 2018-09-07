require 'sequel'
require 'sqlite3'
require './database'

class Product


    def initialize()
        @table = nil
        puts "Product Created"
    end

    attr_accessor :table

    def self.connect(database,args)
        @table = Table.create_table(database,args)
    end

    def self.all
        @table.all
    end

    def self.find(id)
        @table.where(id: id).first


    end

    def self.create(args)
        @table.insert(args)
        @table.find(args[:id]).first
    end

    def self.delete(id)
        if @table.where(id: id).delete
            return true
        else
            return false
        end
    end

    def self.update(id,args)
        if @table.where(id: id).update(args)
            return true
        else
            return false
        end
    end
end

