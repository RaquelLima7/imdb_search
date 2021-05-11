class Movie < ApplicationRecord
  belongs_to :director

  # a gem incluída no gemfile para poder pesquisar
  # https://github.com/Casecommons/pg_search => doc da gem
  include PgSearch::Model
  multisearchable against: [:title, :synopsis]

  # :search_by_title_and_synopsis é o nome que quiser
  pg_search_scope :global_search,
  # quais que são as colunas do modelo o qual vai realizar a busca
  # 'A''C' para definir a prioridade na busca => olhar Weighting na doc da gem
    against: { title: 'A', synopsis: 'C' },
  # para poder procurar em diretor também
  # "associated_against:" colunas de outra tabela que quer procurar também
    associated_against: {
      director: [ :first_name, :last_name ]
    },
  # coloca isso, pois se pesquisar uma palavra que não seja completa ele acha
  # digitar "bat superman", ñ digitou batman inteiro, mas vai achar
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
