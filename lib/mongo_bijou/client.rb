require 'singleton'
require 'mongo'

# Module to supply class objects with mongodb storage.
module MongoBijou
  # MongoDB connector.
  class Client
    include Singleton
    # Returns the value of attribute client.
    attr_reader :client, :db_name

    # Returns a new instance of MongoClient.
    def initialize
      @db_name = 'default'
      @client = Mongo::Client.new(['127.0.0.1:27017'], database: @db_name)
    end

    def db_name=(db_name)
      @db_name = db_name
      @client = Mongo::Client.new(['127.0.0.1:27017'], database: @db_name)
    end
  end
end
