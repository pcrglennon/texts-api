require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

class TextsApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :port, 8080
  set :show_exceptions, false

  get '/contacts' do
    Contact.all.to_json
  end

  post '/contacts' do
    contact = Contact.create(params[:contact])
    contact.to_json
  end
end

class Contact < ActiveRecord::Base
  validates_presence_of :name, :phone_number

  def phone_number
    "(#{super[0..2]}) #{super[3..5]}-#{super[6..9]}"
  end

  def phone_number=(number)
    super(number.gsub(/\D/, ''))
  end
end

