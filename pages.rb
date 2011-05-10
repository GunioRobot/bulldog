page '/' do |p|
  p.template  = 'index'
  p.title     = 'Home'
  p.page_type = 'plain'
end


page '/about' do |p|
  p.template = 'about'
  p.title    = 'About Me'
end


page '/contact' do |p|
  p.template = 'contact'
  p.title    = 'Contact Me'
end


page '/archive' do |p|
  p.template = 'archive'
  p.title    = 'The Archives'
end


page '/tag/:tag' do |p, params|
  p.template    = 'tag'
  p.title       = "Tagged:"
  p.hide_in_nav = true
end


page '/404' do |p|
  p.template    = '404'
  p.title       = "Page Not Found"
  p.hide_in_nav = true
end


page '/500' do |p|
  p.template    = '500'
  p.title       = "Oops"
  p.hide_in_nav = true
end
