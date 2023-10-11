require 'http'
require 'json'

require 'dotenv'
Dotenv.load

api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/engines/text-davinci-003/completions"

headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

puts ["\n"]
puts "Bot de tes Rêves : Quel est votre question ?"

conversation_history = "" # si on utilise un array ça fait planter le bébé

loop do
  puts ["\n"]
  print "Vous : "
  user_answer = gets.chomp
  conversation_history += user_answer
  
  if user_answer == 'stop'
    break
  else
    data = {
      "prompt" => conversation_history,
      "max_tokens" => 500,
      "n" => 1,
      "temperature" => 0
    }
    
    response = HTTP.post(url, headers: headers, body: data.to_json)
    response_body = JSON.parse(response.body.to_s)
    response_string = response_body['choices'][0]['text'].strip
    
    puts ["\n"]
    puts "BDTR : #{response_string}"

    conversation_history += response_string
  end
end


