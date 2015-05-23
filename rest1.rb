require 'net/http'
require 'json'

def format_string(s)
  fs=""
  s.each_char do |c|
    if c == ',' then 
      c='+' 
    end
    if c == ' ' then 
      c='+' 
    end
    fs << c
  end
return fs
end
address=format_string('1600,Amphitheater Parkway')
city=format_string('Mountain View')
state=format_string('CA')
apikey='AIzaSyCJfNDM3GSCo89jAsGUSI1fmeuiKSQTuyo'
url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address},#{city},#{state}&key=#{apikey}"
puts url
resp = Net::HTTP.get_response(URI.parse(url))
puts resp.message,resp.code
obj=JSON.parse(resp.body)
p obj["results"][0]["formatted_address"]
