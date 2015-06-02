$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
require 'net/ssh' 
require 'json'
#Ubuntu virtual machine access credentials
@host = "192.168.238.129"
@user = "roberto"
@passw = "texas"
Net::SSH.start(@host, @user, :password => @passw) do |ssh|
  ssh.open_channel do |channel|
    channel.exec("ls -la ./Downloads") do |ch, success|
      abort "could not execute command" unless success
      channel.on_data do |ch, data|
        @d=data
        #puts "got stdout: #{data}"
        #channel.send_data "something for stdin\n"
      end
      channel.on_extended_data do |ch, type, data|
        puts "got stderr: #{data}"
      end
      channel.on_close do |ch|
        puts "channel is closing!"
      end
    end
  channel.wait #this will wait for all channels to finish
  end
  ssh.loop
  f=@d.match (/W.*demo.json/)
  if f==nil then
    puts "JSON file not found" 
  else
    h=ssh.exec!("cat ./Downloads/" + f[0])
    res=JSON.parse(h)
    #puts h
    puts res['widget']['window']['title']
  end
end
