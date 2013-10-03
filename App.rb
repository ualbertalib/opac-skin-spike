require "sinatra"
require "net/http"
require "uri"
require "./symphony2html"
require "./symphony2json"

include Symphony2Html
include Symphony2Json

def open(url)
  Net::HTTP.get(URI.parse(url))
end

get "/" do
  erb :index
end

get "/basic/:searchType/:query" do
  params[:query]
  params[:searchType]
  # remember to uri encode the parameters
  @query=params[:query]
  @searchType=params[:searchType]
  @query_string = "http://ws.library.ualberta.ca/symws3/rest/standard/searchCatalog?clientID=Primo&term1=#{@query}&searchType1=#{@searchType}&includeAvailabilityInfo=true"
  xml_results = open @query_string
  create_html_records xml_results
  @results = html_records #post_to_elasticsearch 
  @hitcount = hitcount 
  erb :html_results
end

get "/facet/:searchType/:query" do
  params[:query]
  params[:searchType]
  # remember to uri encode the parameters
  @query=params[:query]
  @searchType=params[:searchType]
  @query_string = "http://ws.library.ualberta.ca/symws3/rest/standard/searchCatalog?clientID=Primo&term1=#{@query}&searchType1=#{@searchType}&includeAvailabilityInfo=true"
  xml_results = open @query_string
  create_json_records xml_results
  post_to_elasticsearch
  @results = query_elasticsearch
  @hitcount = hitcount
  erb :es_results
end



