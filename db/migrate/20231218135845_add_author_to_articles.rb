class AddAuthorToArticles < ActiveRecord::Migration[7.1]
  def change
    add_reference :articles, :author
  end
end
