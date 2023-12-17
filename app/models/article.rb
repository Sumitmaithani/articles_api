class Article < ApplicationRecord
    validates :title, presence: true, length: { minimum: 3 }
    validates :body, presence: true, length: { minimum: 3 }
    validates :author, presence: true, length: { minimum: 3 }
end
