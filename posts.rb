post '/second-sample-page' do |p|
  p.title        = "Second Sample Page"
  p.subtitle     = "Really really, it's just a sample page"
  p.template     = "sample-page-2"
  p.published_at = DateTime.parse('2011-04-02')
  p.tags         = %w{samples}
  p.summary      = %Q{
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do 
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut 
    enim ad minim veniam, quis nostrud exercitation ullamco laboris 
    nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor 
    in reprehenderit in voluptate velit esse cillum dolore eu fugiat 
  }
end


post '/first-sample-page' do |p|
  p.title        = "First Sample Page"
  p.subtitle     = "Really, it's just a sample page"
  p.template     = "sample-page-1"
  p.published_at = DateTime.parse('2011-04-01')
  p.tags         = %w{samples}
  p.summary      = %Q{
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do 
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut 
    enim ad minim veniam, quis nostrud exercitation ullamco laboris 
    nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor 
    in reprehenderit in voluptate velit esse cillum dolore eu fugiat 
  }
end
