require 'openssl'
require 'google/api_client'

client = Google::APIClient.new(
  :key => 'AIzaSyCJfNDM3GSCo89jAsGUSI1fmeuiKSQTuyo', 
  :authorization => nil,
  :application_name => 'Custom Search API Ruby Demo',
  :application_version => '0.0.1'
)
search = client.discovered_api('customsearch')

response = client.execute(
  :api_method => search.cse.list,
  :parameters => {
    'q' => 'Enphase Energy',
    'key' => 'AIzaSyCJfNDM3GSCo89jAsGUSI1fmeuiKSQTuyo',
    'cx' => '001105557490822457098:mo_oakromlq'
  }
)
items=response.data['items'].size
(0..items-1).each do |i|
printf("%2d  %s",i+1,response.data['items'][i]['title']+"\n")
end
