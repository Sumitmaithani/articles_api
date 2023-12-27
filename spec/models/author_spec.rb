require 'rails_helper'

RSpec.describe Author, type: :model do
  it 'is valid with valid attributes' do
    author = FactoryBot.build(:author, first_name: 'John', last_name: 'Doe', age: 30)
    expect(author).to be_valid
  end

end
