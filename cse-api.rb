require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

require 'google/api_client'
client = Google::APIClient.new(:key => 'AIzaSyCJfNDM3GSCo89jAsGUSI1fmeuiKSQTuyo', :authorization => nil)
search = client.discovered_api('customsearch')

response = client.execute(
  :api_method => search.cse.list,
  :parameters => {
    'q' => 'the hoff',
    'key' => 'AIzaSyCJfNDM3GSCo89jAsGUSI1fmeuiKSQTuyo',
    'cx' => '001105557490822457098:mo_oakromlq'
  }
)
puts response.inspect
