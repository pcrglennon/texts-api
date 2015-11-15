require 'spec_helper'

RSpec.describe Message, type: :model do
  subject { Message.new }

  describe 'relationships' do
    it { should belong_to(:contact) }
  end

  describe 'validations' do
    describe 'content' do
      it { should validate_presence_of(:content) }
    end

    describe 'contact_id' do
      it { should validate_presence_of(:contact_id) }
    end
  end
end

