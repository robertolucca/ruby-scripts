require 'net/http'
require 'json'

url='http://localhost:4567/FamilyMembers'

while true
  print "\n\e[31ms\e[0mearch \e[31ml\e[0mist \e[31ma\e[0mdd \e[31mu\e[0mpdate \e[31md\e[0melete \e[31mq\e[0muit -> "
  resp=gets().chop!
  case(resp)
    when 'l' then
      resp = Net::HTTP.get_response(URI.parse(url))
      print resp.code,'  ',resp.message,"\n"
      puts resp.body
    when 's' then
      print "Name   -> "
      name=gets().chop!
      exit if name == 'q'
      puts name
      resp = Net::HTTP.get_response(URI.parse(url+'/'+name))
      print resp.code,'  ',resp.message,"\n"
      puts resp.body
    when 'q' then
      exit
  end
  #obj=JSON.parse(resp.body)
  #p obj["results"][0]["formatted_address"]
end
