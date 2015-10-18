require 'sinatra'
require 'sinatra/activerecord'

class TextsApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :show_exceptions, false

  get '/' do
    "It's an API"
  end

  get '/contacts' do
    Contact.all.to_json
  end

  post '/contacts' do
    contact_data = JSON.parse(request.body.read, :symbolize_names => true)[:contact]
    contact_data.select! { |k, v| [:name, :phone_number].include?(k) }
    Contact.create(contact_data).to_json
  end
end

class Contact < ActiveRecord::Base
  validates_presence_of :name, :phone_number
  validates :phone_number, numericality: true
  validates :phone_number, length: { is: 10 }

  before_validation :normalize_phone_number

  private

  def normalize_phone_number
    self.phone_number.gsub!(/\D/, '') if self.phone_number.present?
  end
end

