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

get "/search/:searchType/:query" do
  params[:query]
  params[:searchType]
  # remember to uri encode the parameters
  @query=params[:query]
  @searchType=params[:searchType]
  @query_string = "http://ws.library.ualberta.ca/symws3/rest/standard/searchCatalog?clientID=Primo&term1=#{@query}&searchType1=#{@searchType}&includeAvailabilityInfo=true" #&hitsToDisplay=1000"
  xml_results = open @query_string
  create_json_records xml_results
  post_to_elasticsearch
  @results = query_elasticsearch
  @hitcount = hitcount
  erb :es_results
end

get "/record/:recordID" do
  params[:recordID]
  @query=params[:recordID]
  @query_string = "http://ws.library.ualberta.ca/symws3/rest/standard/lookupTitleInfo?clientID=Primo&titleID=#{@query}&includeAvailabilityInfo=true&includeItemInfo=true&includeOPACInfo=true"
  xml_record = open @query_string
  @html_record = create_html_record xml_record
  erb :record_view
end



