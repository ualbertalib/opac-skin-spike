require "nokogiri"
require "active_support/core_ext"
require "json"
require "tire"

json_results = []
doc = Nokogiri::XML(File.open(ARGV[0]).read).remove_namespaces!
doc.xpath("//HitlistTitleInfo").each do |record|
  json_record =
  { :id => record.at_xpath(".//titleID").text, :type=>"Catalogue", :title=>record.at_xpath(".//title").text, :author=>record.xpath(".//author").text, :date=>record.xpath(".//yearOfPublication").text, :isbn=>record.xpath(".//ISBN").text, :oclc=>record.xpath(".//OCLCControlNumber").text, :url=>record.xpath(".//url").text, :call=>record.xpath(".//callNumber").text } 
  json_results << json_record
end

Tire.index 'catalogue' do
  import json_results
end
