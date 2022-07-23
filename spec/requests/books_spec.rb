require 'rails_helper'

describe 'Books API', type: :request do
    describe 'GET/books' do
        before do
          FactoryBot.create(:book, title: '1984', author: 'George Owell')
          FactoryBot.create(:book, title: '1930', author: 'George Owell') 
        end
        it 'returns all books' do 
            get '/api/v1/books'
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end
 
    describe 'POST /books' do
       it 'create a new book' do
        expect{
         post '/api/v1/books', params:{
           book: {title: 'The ocean'},
           author:{first_name: 'Asad', last_name: 'Jaffery' , age: 28} 
        }
        }.to change{ Book.count }.from(0).to(1)
        expect(response).to have_http_status(:created)
        expect(Author.count).to eq(1)
        expect(JSON.parse(response.body)).to eq{
            {
                "id": 1,
                "title": "The Ocean",
                "author_name": "Asad Jaffery",
                "author_age" => 48 
            }
        }
       end
    end

    describe 'DELETE /books/:id' do
        it 'should delete a book' do
            FactoryBot.create(:book, title: '1984', author: 'George Owell')
                delete '/api/v1/books/1'
            expect(response).to have_http_status(:no_content)
        end   
    end
        
end