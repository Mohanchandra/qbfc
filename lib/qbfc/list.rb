module QBFC
  # List objects are those with names, such as Accounts, Entities, and Items.
  # 
  # Note on the name: it doesn't make sense since a List is actually a single object,
  # but it fits with the SDK's naming scheme, and I couldn't think of a better one.
  class List < Element
    is_base_class
    ID_NAME = "ListID"
    
    class << self
      
      # Find by name (actually, FullName) of List record.
      # +options+ are the same as those for in +find+.
      def find_by_name(sess, full_name, options = {})
        q = create_query(sess)
        q.query.FullNameList.Add(full_name)
        find(sess, :first, q, options)
      end
      
      alias_method :find_by_full_name, :find_by_name

      # Find by ListID of List record.
      # +options+ are the same as those for in +find+.      
      def find_by_id(sess, id, options = {})
        q = create_query(sess)
        q.query.ListIDList.Add(id)
        find(sess, :first, q, options)
      end
      
      # Find by either name or id. Tries id first, then name.
      def find_by_name_or_id(*args)
        find_by_id(*args) || find_by_name(*args)
      end
      
      alias_method :find_by_unique_id, :find_by_name_or_id
      
    end
    
    # Alias of ListID for this record. This is a unique within each type of List.
    def id
      @ole.list_id
    end
    
    # If an entity has a Name field but not a FullName field,
    # use Name (which, by implication, is the FullName)
    def full_name
      respond_to_ole?("FullName") ?
        @ole.full_name :
        @ole.name
    end
    
    # Delete this List record.
    def delete
      req = QBFC::Request.new(@sess, "ListDel")
      req.list_del_type = QBFC_CONST::const_get("Ldt#{qb_name}")
      req.list_id = id
      req.submit
      return true
    end
    
    # Display the Transaction add (for new records) or edit dialog box
    def display
      if new_record?
        req = QBFC::Request.new(@sess, "ListDisplayAdd")
        req.list_display_add_type = QBFC_CONST::const_get("Ldat#{qb_name}")
      else
        req = QBFC::Request.new(@sess, "ListDisplayMod")
        req.list_display_mod_type = QBFC_CONST::const_get("Ldmt#{qb_name}")
        req.list_id = id
      end
      req.submit
      return true
    end
  end
end

# Require subclass files
%w{ entity item terms }.each do |file|
  require 'qbfc/' + file
end

Dir.new(File.dirname(__FILE__) + '/lists').each do |file|
  require('qbfc/lists/' + File.basename(file)) if File.extname(file) == ".rb"
end
