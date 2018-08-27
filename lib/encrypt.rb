require './lib/enigma'

e = Enigma.new

code = ARGV[0]
message = File.open("./lib/#{code}", "r")
secret = message.read

target = ARGV[1]
encryption = File.open("./lib/#{target}", "w")
encryption.write("#{e.encrypt(secret)}")
encryption.close
encryption = File.open("./lib/#{target}", "r")
puts "Created '#{target}' with the key #{e.key} and date #{e.set_date}"
