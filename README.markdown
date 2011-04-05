# Bulldog

Bulldog is a simple blogging platform designed to solve a few simple goals:

* Development of layout, pages and new posts happens on my laptop
* Free to deploy (via Heroku)
* Dead simple to understand and modify
* Written in Ruby so it's easy to hack
* Layout, posts and pages written in Haml, because I like Haml
* Meta data separated from the page and post content, because it seems cleaner
* Simple layout scheme that isn't really theme based
* Comments handled by an outside service (in my case, disqus)

# Quick Setup

Assuming you have a heroku account, you can do this -- fork the repo, and clone it to your local machine, then:

* Edit blog_config.rb to provide your name, profile and other information
* git commit -a -m "First Blog Commit"
* heroku create
* git push heroku master
* heroku open

At that point you should be staring at your new blog, with sample content.

To create your first post:

* Edit a new post in the file posts/{your-post-template-name}.haml
* Add a new post to the top of the file posts.rb
		post '/choose-an-appropriate-slug' do |p|
			p.title = "Insert Title Here"
			p.template = "your-post-template-name"
			p.published_at = DateTime.parse('2011-04-01')   # Choose a date
		end
* git commit -a -m "First Post"
* git push heroku master
* heroku open

You may want to preview things before you actually make them live, but that's entirely up to you. How you do that depends on your own server setup.

## Configuration

The main blog configuration code is in the file blog_config.rb, and contains settings for blog name, description, profile image, favicon, disqus, analytics, etc. There are required elements and optional elements. Of course
you can just go edit the layouts files directly if you want.

## Defining Pages and Posts

Bulldog is built using Sinatra and Haml. It operates on a few really simple principles. There are two types of objects in the system - pages and posts.

Pages and posts are written in Haml, which means that they can also include ruby code. Pages and posts are added to the blog by declaring them using this syntax:

	  #-----------
	  # pages.rb
	  #-----------
	  page '/about' do |p|
	    p.template = 'about'
	    p.title    = 'About Me'
	  end

	  # ... more like this ...


	  #-----------
	  # posts.rb
	  #-----------
	  post '/writing-an-instagram-web-client' do |p|
	    p.title        = 'Writing an Instagram Web Client'
	    p.subtitle     = 'Ahhh, Paris...'
	    p.template     = 'writing-an-instagram-web-client'
	    p.published_at = DateTime.parse('2011-03-24')
	    p.tags         = %w{instagram}
	    p.summary      = %Q{
	      Most of my Instagram consumption happens outside my phone, 
	      which makes it hard to follow people. I wrote an Instagram 
	      client to make that easier.
	    }
	  end

	  # ... more like this ...

In the end this means is that a page is defined by two elements:

* The page content
* Meta data defined by this simple Hash

Pages and posts are declared in the files pages.rb and posts.rb. The content for a page is in the file pages/{page-template-name}.haml and posts are located in the file posts/{post-template-name}.haml


## Rendering Pages and Posts

Pages and posts are rendered inside layouts. All layout related information is stored in the folder layout/. The default layout for a page is layout/page.haml. The default layout for a post is layout/post.haml. An individual page or post can override this default by setting a new layout in the declaration, so:

		 page '/' do |p|
		   # ...
		   p.layout = 'blank'   # or any other layout name you want
		 end

When a page or post is rendered, the page template, and all the layout code has access to a variable @page. (This name "@page" is used for both pages and posts, to keep layout code simpler). It also has access to all pages and posts via the variables @posts and @pages. This is useful for rendering "recent posts" or navigational elements.

The variable @page is set to the Hash of attributes which were set in the declaration of the page or post. In practice this means that you can go and add attributes any time you want by simply declaring them and then using them in a template or layout.


## Nesting Layouts and Partials

Since it is really common in a blog to have nested layouts (e.g. post is rendered in a layout that has a title and that is rendered in a layout that has the sidebar + chrome), there are a few extensions to Sinatra.

"inside" - This helper allows you to define a Haml block that is rendered inside another layout, so:

	  = inside :master_layout do
	    %p Content here...

"partial" - This helper allows you to render a partial template without any layout, so:

	  = partial :'sidebar/sidebar'


## Redirects

If you have specific redirects you want to handle (e.g. you renamed a post), this is done in the file redirects.rb. The syntax is pretty simple:

	  module Redirect
	    #::::::::::::::::::::::::::::::::::::::::::::::::::::::
	    # Which URLs to redirect
	    Urls = {
	      '/old/path' => '/new/path'
	    }
	  end 

This mapping is used in the code that handles page-not-found (404) errors. If there is no matching page, then the redirects are checked before telling the user that the page could not be found.


## Organization

* Code to manage the blog is located in lib/**.rb
* The main sinatra app is located in blog_app.rb, and manages RSS feeds, CSS, 404 and 500 errors.
* Declaration of pages and posts is in pages.rb and posts.rb
* Post content is located in posts/*.haml
* Page content is located in pages/*.haml
* Custom redirects are located in redirects.rb
