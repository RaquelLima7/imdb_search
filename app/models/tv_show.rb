class TvShow < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:title, :synopsis]
end


# tipo de busca que retorna mais de um modelo 
# rails g pg_search:migration:multisearch
# rails db:migrate
