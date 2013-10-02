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

get "/search/:searchType/:query" do
  params[:query]
  params[:searchType]
  # remember to uri encode the parameters
  @query=params[:query]
  @searchType=params[:searchType]
  @query_string = "http://ws.library.ualberta.ca/symws3/rest/standard/searchCatalog?clientID=Primo&term1=#{@query}&searchType1=#{@searchType}&includeAvailabilityInfo=true"
  xml_results = open @query_string
  create_json_records xml_results
  @results = post_to_elasticsearch 
  @hitcount = hitcount 
  erb :results
end

get "/local" do
  erb :local
end

