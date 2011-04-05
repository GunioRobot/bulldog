require 'hashie'
require 'date'

#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# PageSet --
# Captures the idea of a set of pages of varying types, with
# tools for extracting subsets of the entire collection.
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
class PageSet
  @@all_pages     = []
  @@pages_by_type = Hashie::Mash.new


  #::::::::::::::::::::::::::::
  # Add a page to the page list
  def self.add_page(page)
    # Apply defaults
    page = Hashie::Mash.new({
      :published_at => DateTime.now,
      :tags         => []
    }).merge(page)

    # Add to the global list
    @@all_pages << page

    # Add to the "by type" list
    @@pages_by_type[page.page_type] ||= []
    @@pages_by_type[page.page_type] << page
    
    # Allow for tag filtering on the array
    self.add_tag_filtering_to(@@pages_by_type[page.page_type])
    
    # Return the added page
    page
  end
  

  #::::::::::::::::::::::::::::
  # Return the set of all pages
  def self.all_pages
    @@all_pages
  end
  
  
  #::::::::::::::::::::::::::::::::::::::::::::
  # Return the set of all pages of a given type
  def self.all_pages_of_type(page_type)
    @@pages_by_type[page_type]
  end
  
  
  #::::::::::::::::::::::::::::::::::::::::::::
  # Given a path, find the page
  def self.find_by_path(path)
    @@all_pages.detect{|p| p.path == path}
  end
  
  
  #:::::::::::::::::::::::::::::::::::::::::::
  # Set up all pages at the start of a request
  def self.config_for_request(request, params)
    @@all_pages.each do |page|
      # Allow for varying levels of details in callback
      case page.config_block.arity
      when 1
        page.config_block.call(page)
      when 2
        page.config_block.call(page, params)
      when 3
        page.config_block.call(page, params, request)
      end
    end
  end


  #::::::::::::::::::::::::::::::::::::::::::
  # Add tag-filtering to a given array object
  def self.add_tag_filtering_to(array)
    def array.tagged_with(tag)
      self.select{|p| p.tags.include?(tag) }
    end
  end
end
