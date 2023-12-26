class ArticlesRepresenter

    def initialize(articles)
        @articles = articles
    end

    def as_json
        articles.map do |article| 
            {
                id: article.id,
                title: article.title,
                body: article.body,
                author_name: author_name(article),
                author_age: article.author.age
            }
        end
    end

    private

    attr_reader :articles

    def author_name(article)
        "#{article.author.first_name} #{article.author.last_name}"
    end

end