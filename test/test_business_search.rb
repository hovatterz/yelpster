require 'rubygems'
require 'test/unit'
require 'yelpster'
require File.dirname(__FILE__) + '/yelp_helper'

class TestBusinessSearch < Test::Unit::TestCase
  include YelpHelper
  
  def setup
    create_client YelpHelper::API_V2
  end
  
  BUSINESS_LAT = 37.7842849
  BUSINESS_LON = -122.481628
  BUSINESS_LOCATION = {
    "cross_streets"=>"21st Ave & 22nd Ave",
    "city"=>"San Francisco", 
    "display_address"=>["5950 California St", "(b/t 21st Ave & 22nd Ave)", "Outer Richmond", "San Francisco, CA 94121"], 
    "geo_accuracy"=>8,
    "neighborhoods"=>["Outer Richmond"], 
    "postal_code"=>"94121", 
    "country_code"=>"US", 
    "address"=>["5950 California St"], 
    "coordinate"=>{"latitude"=>BUSINESS_LAT, "longitude"=>BUSINESS_LON},
    "state_code"=>"CA"
    }

  def test_bounding_box_search
    request = Yelp::V2::Search::Request::BoundingBox.new(
                :sw_latitude => 37.9,
                :sw_longitude => -122.5,
                :ne_latitude => BUSINESS_LAT,
                :ne_longitude => BUSINESS_LON,
                :term => 'yelp')
    response = @client.search(request)
    validate_json_to_ruby_response(response)
  end
  
  def test_geo_point_search
    request = Yelp::V2::Search::Request::GeoPoint.new(
      :latitude => BUSINESS_LAT,
      :longitude => BUSINESS_LON
    )
    response = @client.search(request)
    validate_json_to_ruby_response(response)
    assert_equal response['businesses'].first["location"], BUSINESS_LOCATION
  end
  
  def test_location_search
    request = Yelp::V2::Search::Request::Location.new(
      :address => BUSINESS_LOCATION["address"].first,
      :city => BUSINESS_LOCATION["city"],
      :state => BUSINESS_LOCATION["state_code"],
      :zipcode => BUSINESS_LOCATION["postal_code"],
      :geo_accuracy => BUSINESS_LOCATION["geo_accuracy"]
    )
    response = @client.search(request)
    validate_json_to_ruby_response(response)
    assert_equal response['businesses'].first['location'], BUSINESS_LOCATION
  end
end

