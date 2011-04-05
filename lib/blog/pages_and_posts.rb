#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#  Utilities for Defining Pages and Posts
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Create a page, and add it to our page-set
def page(path, page_type = 'page', &block)
  # Add the new page to our set
  PageSet.add_page({
    :path         => path,
    :page_type    => page_type,
    :config_block => block.to_proc
  })
  
  # Define the action for the page
  get path do
    render_page(path)
  end
end


#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Create a post and add it to our set of pages
def post(path, &block)
  page(path, 'post', &block)
end


#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Given a path, find the page for it and render that page
def render_page(path)
  # The page to show
  new_page = PageSet.find_by_path(path)

  # Our pages and posts
  @pages = PageSet.all_pages_of_type('page')
  @posts = PageSet.all_pages_of_type('post')

  # So the templates can access the data
  @page = new_page
  
  # Render page type to embed the content
  render :haml, @page.page_type.to_sym, :layout => false
end
