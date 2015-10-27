Dir["#{Dir.pwd}/lib/mongo_bijou/*.rb"].each { |file| require_relative file }

# Module to supply class objects with mongodb storage.
module MongoBijou
  # Returns the value of attribute config_attr.
  attr_accessor :config_attr

  def self.included(klass)
    klass.extend Murderer
    klass.extend Boaster
  end

  # Default configuration for object attributes to be saved in db - all.
  def attr_defaults
    @config_attr = crusher.to_hash(self)
  end

  def db_name=(name)
    Client.instance.db_name = name
  end

  # Call this method on object to perform saving
  # object with configured attributes.
  def mongo_store
    attr_defaults if config_attr.nil?
    attr = crusher.crush(config_attr)
    client = Client.instance.client[collection_name]
    client.insert_one(attr).inserted_id.to_s
  end

  private

  def collection_name
    self.class.to_s.downcase
  end

  def crusher
    Crusher.new(self)
  end
end
