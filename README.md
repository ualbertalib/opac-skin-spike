Proof-of-concept of lightweight OPAC.

Use Symphony API to pull in search results
Ingest this data into ElasticSearch from which it can be exposed in JSON.
Use the Tire gem project to expose the catalogue data in faceted view.

WS End Point: http://ws.library.ualberta.ca/symws3/rest/standard/searchCatalog?clientID=Primo&term1=shakespeare&includeAvailabilityInfo=true
