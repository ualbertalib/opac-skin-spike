require "nokogiri"
require "active_support/core_ext"
require "json"
require "tire"

module QuickOpac
  
  @@html_results = []

  def create_html_records(xml)
    doc = Nokogiri::XML(xml).remove_namespaces!
    doc.xpath("//HitlistTitleInfo").each do |record|
      html_record = "<div id=#{record.at_xpath('.//titleID').text}><p>Title: #{record.at_xpath('.//title').text}</p><p>Author: #{record.xpath('.//author').text}</p><p>Year: #{record.xpath('.//yearOfPublication').text}</p><p>ISBN: #{record.xpath('.//ISBN').text}</p><p>OCLC Number: #{record.xpath('.//OCLCControlNumber').text}</p><p>Online Access: #{record.xpath('.//url').text}</p><p>Call Number: #{record.xpath('.//callNumber').text}</p>" 
      @@html_results << html_record
    end
    @hitcount = doc.at_xpath("//totalHits").text
  end

  def html_records
    @@html_results
  end

  def hitcount
    @hitcount
  end

end
