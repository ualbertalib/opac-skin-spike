require "sinatra"
require "net/http"
require "uri"
require "./symphony2json"

include QuickOpac

def open(url)
  Net::HTTP.get(URI.parse(url))
end

get "/" do
  erb :index
end

get "/search/:query" do
  params[:query]
  @query=params[:query]
  xml_results = open("http://ws.library.ualberta.ca/symws3/rest/standard/searchCatalog?clientID=Primo&term1=#{:query}&includeAvailabilityInfo=true")
  create_json_records xml_results
  @results = post_to_elasticsearch  
  erb :results
end

get "/hello/:name" do
  params[:name]
end

