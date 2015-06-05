require "rest-client"
require "json"

# greet user
puts "Hello! Welcome to Petitions"

puts # for creating a space instead of \n\n

puts "What kind of petitions would you like to see? ('open' or 'closed'?)"

status = gets.strip
offset = 0

puts "Showing petitions of status: #{status}"

while true
	# get the petitions
	# petitions = ["Gun Control","Cannabis","Immmigration"]
	response =  result = RestClient.get "https://api.whitehouse.gov/v1/petitions.json?status=#{status}"

	parsed_response = JSON.parse(response)

	petitions = parsed_response["results"]

	if petitions.size == 0
		"No more petitions :("
		break
	end

	# print each petition
	petitions.each_with_index do |petition, index|
		puts "#{offset + index + 1}. [#{petition["status"].upcase}] #{petition["title"]}"
	end
	offset = offset + 10 #can also write offset += 10

	puts "Would you like to see more? (y/n)"

	input = gets.strip
	#if input == "y"
	break if input == "n" # can write break if gets.strip = "n"

end
puts

#goodbye
puts "Bye Bye!"