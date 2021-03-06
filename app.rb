# Arquivo principal do aplicativo

# Importa as bibliotecas importantes para a aplicação
require 'json'
require 'sinatra'
require 'sinatra/activerecord'

# Importa o arquivo de configuração do banco
require './config/database'

Dir["./app/models/*.rb"].each {|file| require file }

class App < Sinatra::Base
  get '/' do
    'hello world'
  end

  post '/webhook' do
    request.body.rewind # o sinatra precisa desse comando para processar a request
    result = JSON.parse(request.body.read)["queryResult"]
 
    if result["contexts"].present?
      response = InterpretService.call(result["action"], result["contexts"][0]["parameters"])
    else
      response = InterpretService.call(result["action"], result["parameters"])
    end
 
    content_type :json, charset: 'utf-8'
    {
      "payload": {
        "telegram": {
          "text": response,
          "parse_mode": "Markdown"
        }
      }
    }.to_json
  end
end