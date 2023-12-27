require 'rails_helper'

describe 'Articles Api', type: :request do
     let(:first_author) { FactoryBot.create(:author, first_name: "funshuk", last_name: "waggudu", age: 45) }
    let(:second_author) { FactoryBot.create(:author, first_name: "funshuk", last_name: "waggudu", age: 45) }

    describe ' GET /articles' do 
        before do
            FactoryBot.create(:article, title: "sample1", body: "this is demo", author: first_author)
            FactoryBot.create(:article, title: "sample2", body: "this is demo", author: second_author)
        end
        
        it 'required all articles' do
            get '/api/v1/articles'

            expect(response).to have_http_status(200)
            expect(response_body.size).to eq(2)
            expect(response_body).to eq(
            [
                {
                    "id" => 1,
                    "title" => "sample1",
                    "body" => "this is demo",
                    "author_name" => "funshuk waggudu",
                    "author_age" => 45
                },
                {
                    "id" => 2,
                    "title" => "sample2",
                    "body" => "this is demo",
                    "author_name" => "funshuk waggudu",
                    "author_age" => 45
                }
            ]
            )
        end

        it 'return a subset of articles based on limit and offset' do
            get '/api/v1/articles', params: { limit: 1 }

            expect(response).to have_http_status(200)
            expect(response_body.size).to eq(1)
            expect(response_body).to eq(
            [
                {
                    "id" => 1,
                    "title" => "sample1",
                    "body" => "this is demo",
                    "author_name" => "funshuk waggudu",
                    "author_age" => 45
                }
            ]
            )
        end

        it 'return a subset of articles based on limit and offset' do
            get '/api/v1/articles', params: { limit: 1, offset: 1 }

            expect(response).to have_http_status(200)
            expect(response_body.size).to eq(1)
            expect(response_body).to eq(
            [
                {
                    "id" => 2,
                    "title" => "sample2",
                    "body" => "this is demo",
                    "author_name" => "funshuk waggudu",
                    "author_age" => 45
                }
            ]
            )
        end

        it 'had a max limit of 100' do
            expect(Article).to receive(:limit).with(100).and_call_original

            get '/api/v1/articles', params: { limit: 999 }
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
            expect(response_body).to eq(
                {
                    "id" => 1,
                    "title" => "sample1",
                    "body" => "this is demo",
                    "author_name" => "funshuk wagodu",
                    "author_age" => 46
                }
            )
            expect(Author.count). to eq(1)
        end
    end

    describe 'DELETE /articles/:id' do
        it 'delete a article' do
            article = FactoryBot.create(:article, title: "sample1", author: first_author, body: "this is demo")
            
            expect {
                delete "/api/v1/articles/#{article.id}"
            }.to change { Article.count }.from(1).to(0)

            expect(response).to have_http_status(200)
        end
    end

end