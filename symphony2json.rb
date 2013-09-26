require "nokogiri"
require "active_support/core_ext"
require "json"

doc = Nokogiri::XML(File.open(ARGV[0]).read)
json_results = Hash.from_xml(doc.to_xml).to_json
of = File.open(ARGV[1], "w")
#replace this with direct ingest to ElasticSearch
of.puts json_results
of.close

