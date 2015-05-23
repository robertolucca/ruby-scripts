require 'net/http'
require 'json'

#--replaces commas and spaces with +
#--then eliminates spaces, newlines and carriage returns
def fstr(s)
s.gsub!(/[, ]/,'+')
s.strip!
end

#-- API_KEY obtained from Google Developers Console
apikey='AIzaSyCJfNDM3GSCo89jAsGUSI1fmeuiKSQTuyo'

print "Enter Address  -> "
address=fstr(gets())
print "Enter City     -> "
city=fstr(gets())
print "Enter State    -> "
state=fstr(gets())
url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address},#{city},#{state}&key=#{apikey}"
resp = Net::HTTP.get_response(URI.parse(url))
print resp.code,'  ',resp.message,"\n"
obj=JSON.parse(resp.body)
p obj["results"][0]["formatted_address"]
p obj["results"][0]["geometry"]["location"]["lat"]
p obj["results"][0]["geometry"]["location"]["lng"]

