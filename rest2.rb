require 'net/http'
require 'json'

apikey='AIzaSyCJfNDM3GSCo89jAsGUSI1fmeuiKSQTuyo'
address="1600,Amphitheater Parkway".gsub(/[, ]/,'+')
city='Mountain View'.gsub(/[, ]/,'+')
state='CA'.gsub(/[, ]/,'+')
address="10669 Caminito Chueco".gsub(/[, ]/,'+')
city='San Diego'.gsub(/[, ]/,'+')
state='CA'.gsub(/[, ]/,'+')
url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address},#{city},#{state}&key=#{apikey}"
puts url
resp = Net::HTTP.get_response(URI.parse(url))
puts resp.message,resp.code
obj=JSON.parse(resp.body)
p obj["results"][0]["formatted_address"]
p obj["results"][0]["geometry"]["location"]["lat"]
p obj["results"][0]["geometry"]["location"]["lng"]
