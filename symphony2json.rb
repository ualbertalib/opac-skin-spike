require "nokogiri"
require "active_support/core_ext"
require "json"
require "pp"

json_results = []
doc = Nokogiri::XML(File.open(ARGV[0]).read).remove_namespaces!
doc.xpath("//HitlistTitleInfo").each do |record|
  json_results << Hash.from_xml(record.to_xml).to_json
end
#replace this with direct ingest to ElasticSearch
of = File.open(ARGV[1], "w")
of.puts json_results
of.close

