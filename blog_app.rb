require 'sinatra'
require 'haml'
require 'lib/blog'

# Load the blog contents
require 'blog_config'
require 'pages'
require 'posts'
require 'redirects'

# Haml config
set :haml, :format => :html5


#::::::::::::::::::::::::::::::::::::::::
# Before every page load
#::::::::::::::::::::::::::::::::::::::::
before do
  # Set up pages before we process them
  PageSet.config_for_request(request, params)
end


#::::::::::::::::::::::::::::::::::::::::
#  SCSS and other "Static" Content
#::::::::::::::::::::::::::::::::::::::::
get '/styles.css' do
  scss :'stylesheets/styles'
end


#::::::::::::::::::::::::::::::::::::::::
#  RSS feed, hand coded
#::::::::::::::::::::::::::::::::::::::::
get '/rss' do
  # Ensure the response is useful for the caller
  cache_control :public, :must_revalidate, :max_age => 60
  content_type 'application/rss+xml'
  
  # For URL generation
  url_prefix = "#{request.scheme}://#{request.host_with_port}"

  # Generate the feed
  builder do |xml|
    xml.instruct! :xml, :version => '1.0'
    xml.rss :version => "2.0" do
      xml.channel do
        xml.title       BlogConfig.title
        xml.description BlogConfig.description
        xml.link        url_prefix

        PageSet.all_pages_of_type('post').each do |post|
          xml.item do
            xml.title         post.title
            xml.link          "#{url_prefix}#{post.path}"
            xml.description   render(:haml, post.template.to_sym, {}, {:layout => false})
            xml.pubDate       Time.parse(post.published_at.to_s).rfc822()
            xml.guid          "#{url_prefix}#{post.path}"
          end
        end
      end
    end
  end
end


#::::::::::::::::::::::::::::::::::::::::
#  Error Handling
#::::::::::::::::::::::::::::::::::::::::
not_found do
  # Check to see if we have a redirect for this path
  Redirect::Urls.each do |from_path, to_path|
    if (from_path == request.path) then
      redirect(to_path)
      halt
    end
  end
  
  # Nope...
  render_page '/404'
end

error do
  render_page '/500'
end
