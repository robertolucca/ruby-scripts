$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
require 'net/ssh' 
@host = "192.168.238.129"
@user = "roberto"
@passw = "texas"
@cmd = "ls|grep ^D"
Net::SSH.start(@host, @user, :password => @passw) do |session|
  res=session.exec!(@cmd)
  puts "ls command:",res

  ret=session.exec!( "echo \"5*3\" |bc" )
  puts "bc command:",ret
end
