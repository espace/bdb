require 'bdb'

module BDB
  
  class HashTable
    def initialize(file_name = nil,table_name = nil, marshal= false, env=nil)
      @env = env
      @db = env ? env.db : Bdb::Db.new
      @file_name = file_name
      @table_name = table_name
      @db.open(nil, file_name,  table_name, Bdb::Db::HASH, Bdb::DB_CREATE, 0)    
      @marshal = marshal
    end
    
    def put(key,data,transaction=nil,flags=0)
      @db.put(transaction, format_data(key), @marshal ? Marshal.dump(data): format_data(data), flags)
    end
    
    def []=(key, data)
      put(key, data)
    end    

    def get(key,data=nil,transaction=nil,flags=0)
     key,val =  @db.get(transaction, format_data(key), data, flags)
     [key, @marshal ? Marshal.load(val) : val ] if val
    end
    
    def [](key)
      get(key)
    end


    def add_btree_index
      @index =  BTree.new(@file_name , @table_name + "_index",@marshal,@env)
      @db.associate(nil,@index.db,0,proc {|s,key,data| data } )
    end

    def find_in_index(data)
      @index.pget(data)  if @index
    end

   def smallest_element
      @index.first
   end
  
    def delete(key,data=nil,transaction=nil,flags=0)
       @db.del(transaction,format_data(key),  flags)
    end

    def close
      @db.close(0)
    end
  
  protected
    def format_data(key)
        if key.is_a? ::Fixnum
          return sprintf("%010d", key)
        elsif key.is_a? ::Float
          return sprintf("%020f", key) 
        end
        key
      end

  end
  
end

if __FILE__ == $0
  
end
