require "nokogiri"
require "active_support/core_ext"

module Symphony2Html
  
  @@html_record = ""

  def create_html_record(xml)
    doc = Nokogiri::XML(xml).remove_namespaces!
    record = doc.at_xpath("//TitleInfo")
    @@html_record = "<div id=#{record.at_xpath('.//titleID').text}><p>Title: #{record.at_xpath('//title').text}</p><p>Author: #{record.xpath('.//author').text}</p><p>Year: #{record.xpath('.//yearOfPublication').text}</p><p>ISBN: #{record.xpath('.//ISBN').text}</p><p>OCLC Number: #{record.xpath('.//OCLCControlNumber').text}</p><p>Online Access: #{record.xpath('.//url').text}</p><p>Call Number: #{record.xpath('.//callNumber').text}</p>" 
    @hitcount = doc.at_xpath("//totalCopiesAvailable").text
    @@html_record
  end

  def hitcount
    @hitcount
  end

end
