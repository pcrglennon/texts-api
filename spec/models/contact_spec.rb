require 'spec_helper'

RSpec.describe Contact, type: :model do
  subject { Contact.new }

  describe 'relationships' do
    it { should have_many(:messages) }
  end
  describe 'validations' do
    describe 'name' do
      it { should validate_presence_of(:name) }
    end

    describe 'phone_number' do
      it { should validate_presence_of(:phone_number) }
      it { should validate_numericality_of(:phone_number) }

      it 'should allow exactly 10 characters' do
        subject.phone_number = '555555555'
        subject.save

        expect(subject.errors[:phone_number]).to include('is the wrong length (should be 10 characters)')
      end
    end
  end

  describe 'before_save' do
    let(:contact) { Contact.new(name: 'Bob') }

    it 'should strip any non-numeric characters from phone number' do
      contact.phone_number = '(555) 555-5555'
      contact.save

      expect(contact.phone_number).to eq('5555555555')
    end
  end
end

