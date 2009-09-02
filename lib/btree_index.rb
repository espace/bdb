require 'bdb'
module BDB
 module BtreeIndex 
    
   def DBTable.included(base)
      table_name = base.to_s.downcase
      base.const_set "INDEX" , Btree.new(table_name)      
      base.extend ClassMethods
      base.send :include , InstanceMethods
   end
  


  module InstanceMethods
    def save
     raise "Hey, Can't Save Without an ID !!!" unless @id
     self.class::TABLE.put(@id.to_s,Marshal.dump(self))
    end  
  end
   
  module ClassMethods

   def find(id)
     Marshal.load(self::TABLE.get(id))
   end
   
   def add_index column
          
   end 
   
  end

 end
end
