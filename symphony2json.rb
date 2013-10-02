require "nokogiri"
require "active_support/core_ext"
require "json"
require "tire"

module QuickOpac
  
  @@json_results = []

  def create_json_records(xml)
    doc = Nokogiri::XML(xml).remove_namespaces!
    doc.xpath("//HitlistTitleInfo").each do |record|
      json_record =
      { :id => record.at_xpath(".//titleID").text, :type=>"Catalogue", :title=>record.at_xpath(".//title").text, :author=>record.xpath(".//author").text, :date=>record.xpath(".//yearOfPublication").text, :isbn=>record.xpath(".//ISBN").text, :oclc=>record.xpath(".//OCLCControlNumber").text, :url=>record.xpath(".//url").text, :call=>record.xpath(".//callNumber").text } 
      @@json_results << json_record
    end
    @hitcount = doc.at_xpath("//totalHits").text
  end

  def post_to_elasticsearch
    Tire.index 'catalogue' do
      delete
      create
      import @@json_results
      refresh
    end
    @@json_results
  end

  def hitcount
    @hitcount
  end

end
