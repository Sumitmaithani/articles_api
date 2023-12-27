require 'rails_helper'

describe 'Articles Api', type: :request do
    describe ' GET /articles' do
        before do
            FactoryBot.create(:article, title: "sample1", author: "funshuk wagodu", body: "this is demo")
            FactoryBot.create(:article, title: "sample2", author: "funshuk wagodu", body: "this is demo")
        end
        
        it 'required all articles' do
            get '/api/v1/articles'

            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end

    describe 'POST /articles' do
        it 'create a new article' do
            expect {
                post '/api/v1/articles', params: { 
                    article: { title: "sample1", body: "this is demo" },
                    author: {  first_name: "funshuk", last_name: "wagodu", age: "46" }
                }
            }.to change { Article.count }.from(0).to(1)
            expect(response).to have_http_status(200)
            expect(Author.count). to eq(1)
        end
    end

    describe 'DELETE /articles/:id' do
        it 'delete a article' do
            article = FactoryBot.create(:article, title: "sample1", author: "funshuk wagodu", body: "this is demo")
            
            expect {
                delete "/api/v1/articles/#{article.id}"
            }.to change { Article.count }.from(1).to(0)

            expect(response).to have_http_status(200)
        end
    end

end