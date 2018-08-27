require './lib/enigma'
require 'date'

e = Enigma.new

code = ARGV[0]
message = File.open("./lib/#{code}", "r")
coded_message = message.read

target = ARGV[1]
key = ARGV[2]
date = ARGV[3]
encryption = File.open("./lib/#{target}", "w")
encryption.write("#{e.decrypt(coded_message, key, date.to_s)}")
encryption.close

puts "Created '#{target}' with the key '#{key}' and date '#{date}'"
