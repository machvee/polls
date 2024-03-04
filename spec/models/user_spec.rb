require 'rails_helper'

describe User, type: :model do
  let!(:user) { build(:user) }

  describe 'attributes' do
    it 'is valid with expected attributes' do
      expect(user).to be_valid
    end

    it 'is invalid without a name attribute' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'is invalid without an email attribute' do
      user.email = nil
      expect(user).not_to be_valid
    end
  end
end
