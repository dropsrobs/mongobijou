module MongoBijou
  module Murderer
    def remove(id)
      Client.instance.client[collection_name].delete_one(_id: id)
    end

    def drop
      Client.instance.client[collection_name].drop
    end

    private

    def collection_name
      class_name.downcase
    end

    def class_name
      to_s
    end
  end
end
