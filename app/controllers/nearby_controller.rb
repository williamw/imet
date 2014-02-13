require "net/https"
require "cgi"

#Use my Facebook app credentials to get an access token:
#https://graph.facebook.com/oauth/access_token?client_id=203847266297363&client_secret=6f05b07dd67e0dd016388c630eab6417&grant_type=client_credentials

#Then query for all nearby places with it (distance=250 is 1/4 mile):
#https://graph.facebook.com/search?type=place&center=41.89714337333333,-87.64375153833333&distance=250&access_token=203847266297363|OosLwJtt13tuAQTJkrZzrLRlalQ

class NearbyController < ApplicationController
  def fb_json
    #1. Get the OAuth access_token using my Facebook app credentials
    #Need error handling here. (Assumes access_token is returned)
    access_token = get_https("https://graph.facebook.com",
                         "/oauth/access_token",
                         {"client_id"     => "644603222253805",
                          "client_secret" => "c1819eb3bb3dc02d9ce49a98bb7f7d57",
                          "grant_type"    => "client_credentials"}).body.split("=")
    
    #2. Render the nearby places as plain-text in JSON format
    #Need error handling here. (Assumes JSON of nearby places is returned)
    #Need to look into using an MVC-style view template here instead
    render :json => get_https("https://graph.facebook.com",
                         "/search",
                         {"type" => "place",
                          "distance" => "250",
                          "center" => params[:location],
                          access_token[0] => access_token[1]}).body
  end

  def get_https(domain, path, params)
    #Needs error handling for when not all variables are not passed in  
    full_uri = domain, "#{path}?".concat(
      params.collect{|k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))

    #Using full_uri here causes an error, even though it is a valid URI
    uri = URI.parse(domain)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(full_uri)
    return response = http.request(request)
  end
end