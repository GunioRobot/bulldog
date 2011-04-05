#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Support for finding templates in all our different locations
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set :views, ['posts', 'pages', 'layout']

helpers do
  def find_template(views, name, engine, &block)
    Array(views).each { |v| super(v, name, engine, &block) }
  end
end



#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Sinatra Extentions - HAML support only
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
module Sinatra
  module Templates
    #:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    # Render a haml block inside a layout, allowing for recursion
    def inside(layout, options = {}, locals = {}, &block)
      # Capture the content
      output = if respond_to?(:block_is_haml?) && block_is_haml?(block)
        capture_haml(&block)
      else
        block.call
      end
      
      # Render the layout with the contents inside it
      render(:haml, layout, options.merge({:layout => false}), locals) { output }
    end


    #:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    # Render a haml partial
    def partial(partial, locals = {})
      render(:haml, partial, {:layout => false}, locals)
    end
  end
end
