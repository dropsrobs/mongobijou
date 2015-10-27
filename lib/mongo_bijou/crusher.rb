# Module to supply class objects with mongodb storage.
module MongoBijou
  CORE_TYPES =
      [Fixnum, String, TrueClass, FalseClass, Bignum, Array, Hash, NilClass]

  # Class able to create deep-nested hash of object's attributes.
  class Crusher
    #  Returns a new instance of AttributesFormatter.
    def initialize(object)
      @object = object
    end

    # Runs #scan_attr(attributes) method and deletes
    # :config_attr from received hash.
    # Then it adds class name, that included module, to formatted hash
    # (necessary when retrieving from database).
    def crush(hash)
      { mark_class(@object) => scan(hash) }
    end

    # Creates hash of given object's instance variables.
    def to_hash(object)
      object.instance_variables.each_with_object({}) do |attr, hash|
        hash[attr.to_s.delete('@').to_sym] = object.instance_variable_get(attr)
      end
    end

    private

    # Recursion method. It scans attributes to check if attribute:
    # * is a Ruby core type - leave as it is.
    # * is not a Ruby core type - save class name in symbolized form.
    # * has nested attributes - perform another scan.
    def scan(hash)
      hash.each do |key, value|
        next if belongs_to_core? value
        unless nested?(value)
          hash[key] = mark_class(value)
          next
        end
        hash[key] = nested_to_hash(value)
      end
    end

    def belongs_to_core?(object)
      CORE_TYPES.include? object.class
    end

    def nested?(object)
      object.instance_variables.any?
    end

    def mark_class(object)
      (object.class.to_s + '_class_name').to_sym
    end

    # Symbolize class name and perform another scan
    # with attributes of actual object.
    def nested_to_hash(object)
      { mark_class(object) => scan(to_hash(object)) }
    end
  end
end
