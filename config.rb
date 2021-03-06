###
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###
require "active_support/all"

activate :bourbon

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
require 'uv'
Uv.syntax_path = File.expand_path("../syntax", __FILE__)
helpers do
  def highlight(code, syntax = "emblem")
    path = syntax

    # first check for local syntax overrides...
    localpath = File.expand_path("../syntax/source.#{syntax}.tmSyntax", __FILE__)
    path = localpath if File.exists?(localpath)

    Uv.parse(code, 'xhtml', path, false, 'blackboard')
  end

  def intro_emblem
    example = File.read(File.expand_path("../data/intro.emblem", __FILE__))
    highlight(example.to_s, "emblem")
  end
end

require 'maruku'
helpers do
  def markdown(code)
    doc = Maruku.new(code)
    doc.to_html
  end
end

activate :directory_indexes

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end