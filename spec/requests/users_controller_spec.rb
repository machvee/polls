require 'rails_helper'

describe UsersController, type: :request do
  let(:user) { create(:user) }
  let(:parsed_response) { JSON.parse(response.body) }

  describe 'bogus authorization bearer token' do
    subject { get users_path, headers: {authorization: "Bearer some_bogus_token"} }

    before do
      subject
    end

    context 'when present in request' do
      it 'returns 401 error' do
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unauthorized)
        expect(parsed_response['errors']).to eq('Unauthorized')
      end
    end
  end

  describe 'GET #index' do
    subject { get users_path, headers: {authorization: "Bearer #{token_for(user)}"} }

    before do
      subject
    end

    context 'success' do
      it 'has expected number of Users and expected attributes' do
        expect(parsed_response.length).to eq(1)
        expect(parsed_response).to all(include('name', 'email'))
      end

      it 'matches the correct user' do
        expect(parsed_response[0]['name']).to eq user.name
        expect(parsed_response[0]['email']).to eq user.email
      end
    end
  end
end
