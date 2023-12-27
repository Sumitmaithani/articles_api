class ArticleRepresenter

    def initialize(article)
        @article = article
    end

    def as_json
        {
            id: article.id,
            title: article.title,
            body: article.body,
            author_name: author_name(article),
            author_age: article.author.age
        }
    end

    private

    attr_reader :article

    def author_name(article)
        "#{article.author.first_name} #{article.author.last_name}"
    end

end