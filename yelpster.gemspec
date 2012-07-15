$:.push File.expand_path("../lib", __FILE__)
require "yelpster/version"

Gem::Specification.new do |s|
  s.name        = "yelpster"
  s.version     = Yelp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Walter Korman", "Naveed Siddiqui"]
  s.email       = ["shaper@fatgoose.com", "naveed@10eighteen.com"]
  s.homepage    = "http://github.com/nvd/yelpster"
  s.summary     = "A Ruby interface to the Yelp Developer API for searching local business information."
  s.description = "This is an expansion of the yelp api ruby gem written by Walter Korman. The gem has been extended to support version 2 of the yelp api. V2 supports business details retrieval via yelp id as well as searches for businesses using geo-point, bounding box or address/location. It also uses OAuth for authorization of requests."

  s.required_rubygems_version = ">= 1.3.6"

  s.rubyforge_project         = "yelpster"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "json", "~> 1.7.3"
  s.add_runtime_dependency "echoe", "~> 4.6.3"
  s.add_runtime_dependency "oauth", "~> 0.4.6"
end
