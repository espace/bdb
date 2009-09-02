require 'bdb'
module BDB

  module DBTable 
    
    def DBTable.included(base)
      table_name = base.to_s.downcase
      base.const_set "TABLE" , HashTable.new(table_name)
      base.superclass = "Hash"      
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

      def attributes(*list)
        attr_accessor(*list)
      end   

    end

  end

end
