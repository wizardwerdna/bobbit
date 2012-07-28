class MemoryRepos

  class IndexedRepo

    def all
      @records ||= []
    end

    def store object, key_proc=default_key
      index = record_index_by_key object, key_proc
      if index.nil?
        all << object.clone
      else 
        all[index] = object.clone
      end
    end

    def fetch key, key_proc = default_key 
      record = all.find(->{Repository::NoRecord}){|e| key_proc[e] == key}
      record.clone
    end

    def delete key, key_proc = default_key
      all.delete_if{|e| key_proc[e] == key}
    end

    def default_key
      ->(object){object.send(default_key_message)}     
    end
    alias :get_default_key :default_key

    def set_default_key
      ->(object, value){object.send(default_key_assign_message, value)}
    end

  private
   
    def default_key_message
      :id
    end

    def default_key_assign_message
      (default_key_message.to_s + '=').to_sym 
    end

    def key_present? object, key_message
      !object.send(key_message).nil?
    end

    def make_new_key object, key_message
      next_key = ([].map(&key_message).max{|each| each} || 0) + 1
      object.send default_key_assign_message, next_key
    end

    def record_index_by_key object, key_proc
      index = all.find_index do |each| 
        key_proc[each] == key_proc[object]
      end
    end

  end

  class PageRepo < IndexedRepo

    alias :fetch_by_name :fetch
    alias :delete_by_name :delete

    def default_key_message
      :name
    end

  end

end
