require 'bdb'

module BDB
  
  class Queue
     
     BIGGER_FLAG = "??.??"

     attr_accessor :data_hash

    def initialize(record_length=0,file_name = nil, marshal= false, env=nil)
      @db = env ? env.db : Bdb::Db.new
      #@db.flags = @db.flags 
      #@file_name = file_name
      #@table_name = table_name   
      @record_length = record_length
      @db.record_length=record_length
      @db.open(nil, file_name, file_name, Bdb::Db::QUEUE, Bdb::DB_CREATE , 0)
      @marshal = marshal
    end
    
    def push(data,transaction=nil,flags=0)
         @db.put(transaction,nil, @marshal ? Marshal.dump(data) : format_data(data), flags | Bdb::DB_APPEND)
    end
        
    def pop(transaction=nil,flags=0)
      key,candidate_data = @db.get(transaction,nil,nil, Bdb::DB_CONSUME)
      return [key, @marshal ? Marshal.load(candidate_data) : candidate_data ]
    end

    def db
      @db
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
  btree = BDB::BTree.new('test.tdb')
  #puts "adding 1000 items"
  #1000.times do |i|
  #  btree.put(i, i.to_s)
  #end
  #puts "searching for items with keys bigger than 375"
  #result = btree.get_bigger(375)
  #p result 
  #p result.length 
  #require 'benchmark'
  #puts Benchmark.realtime { 120000.times { |i| btree.put(i, i.to_s) } }
  #btree.close
  #File.unlink('test.tdb')


end
