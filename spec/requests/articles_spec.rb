require 'rails_helper'

describe 'Articles Api', type: :request do
    it 'required all articles' do
        FactoryBot.create(:article, title: "sample1", author: "funshuk wagodu", body: "this is demo")
        FactoryBot.create(:article, title: "sample2", author: "funshuk wagodu", body: "this is demo")

        get '/api/v1/articles'

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).size).to eq(2)
    end
end