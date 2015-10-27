module MongoBijou
  module Boaster
    def find(id)
      doc = find_in_db(id)
      from_doc_to_object(doc)
    end

    def all
      docs = Client.instance.client[collection_name].find.to_a
      docs.each_with_object([]) do |doc, array|
        array << from_doc_to_object(doc)
      end
    end

    private

    def find_in_db(id)
      doc = Client.instance.client[collection_name]
      doc.find(_id: BSON::ObjectId(id)).to_a.first
    end

    def from_doc_to_object(doc)
      obj_attr = object_attr_retrieve(doc)
      hash = build_class_hash(obj_attr)
      object = drill(hash)
      object.config_attr = Crusher.new(self).to_hash(object)
      object
    end

    def object_attr_retrieve(hash)
      hash.keep_if { |key, _value| class_name == unmark_class(key) }
    end

    def drill(hash)
      hash.each do |key, value|
        hash[key] = drill(value) if value.instance_of?(Hash)
        return build_partial(key, value) if class?(key)
      end
    end

    def class?(value)
      value.is_a? Class
    end

    def build_partial(klass, hash)
      hash.each_with_object(klass.new) do |(key, value), partial|
        partial.instance_variable_set("@#{key}".to_sym, value)
      end
    end

    def build_class_hash(hash)
      hash.each_with_object({}) do |(key, value), cpy_hash|
        cpy_key = constantize_if_class(key)
        cpy_hash[cpy_key] = if value.instance_of?(BSON::Document)
                              build_class_hash(value)
                            else
                              value
                            end
      end
    end

    def constantize_if_class(str)
      if marked_as_class?(str)
        Object.const_get(unmark_class(str))
      else
        str
      end
    end

    def marked_as_class?(str)
      unmark_class(str) != str
    end

    def unmark_class(str)
      str.gsub(/_class_name/, '')
    end

    def collection_name
      class_name.downcase
    end

    def class_name
      to_s
    end
  end
end
