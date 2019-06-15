# Arquivo principal do aplicativo

# Importa as bibliotecas importantes para a aplicação
require 'json'
require 'sinatra'
require 'sinatra/activerecord'

# Importa o arquivo de configuração do banco
require './config/database'

# Classe principal da aplicação

class App < Sinatra::Base
  get '/' do
    puts 'hello world'
  end
end