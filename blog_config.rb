#:::::::::::::::::::::::::::::::::::::::::::::
#   Global blog configuration
#:::::::::::::::::::::::::::::::::::::::::::::
BlogConfig = Hashie::Mash.new({
  #:::::::::::::::::::::::::::::::::::::::::::::
  # Required
  #:::::::::::::::::::::::::::::::::::::::::::::

  # Placed in the title tag of every page along with the page title
  :title => 'Your Blog Name',
  
  # Used for the RSS feed and the default page meta description
  :description => 'All the stuff you blog about',
  
  # Path to the favicon for this blog
  :favicon => '/favicon.png',
  
  #::::::::::::::::::::::::::::::::::::::::
  # See layout/sidebar/_about.haml for where these are used
  
  # The owner name, which can easily match the title...
  :owner_name => 'Your Name',

  # Short paragraph about the blog owner
  :about => %Q{
    Your great bio goes here.
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do 
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim 
    ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut ...    
  },
  
  # Square profile image for the blog owner
  :profile_image => '/images/portrait_100x100.jpg',


  #:::::::::::::::::::::::::::::::::::::::::::::
  # Optional
  #:::::::::::::::::::::::::::::::::::::::::::::

  # If you use Feedburner, place the feed URL here. Default path is '/rss'
  # :rss_feed => 'http://feeds.feedburner.com/feedburner-name',
  
  # If you use TypeKit, you should place the script from TypeKit here
  # :typekit => %Q{
  # <script type='text/javascript' src='http://use.typekit.com/big-code-here.js'></script>
  # <script type='text/javascript'>
  #   try{Typekit.load();}catch(e){}
  # </script>
  # },

  # Replace these with real urls to your pages (see layout/sidebar/_social.haml)
  :twitter_url   => 'http://twitter.com/',
  :facebook_url  => 'http://www.facebook.com/',
  :linked_in_url => 'http://www.linkedin.com/',
  :tumblr_url    => 'http://www.tumblr.com/',
  
  # Disqus comment support is enabled by setting this value (see layout/post/_comments.haml)
  # :disqus_shortname => 'disqus_shortname'
})
