class MoviesController < ApplicationController
  def index
    if params[:query].present?
      # para poder procurar tbm nos outros campos
      # @@ separa por espaço e campo inteiro
    # ñ vai precisar desse código pq está usando a gem PgSearch
    #   sql_query = " \
    #   movies.title @@ :query \
    #   OR movies.synopsis @@ :query \
    #   OR directors.first_name @@ :query \
    #   OR directors.last_name @@ :query \
    #  "
    #  @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")
      @movies = Movie.global_search(params[:query])
    else
      @movies = Movie.all
    end
  end
end


# código removido do index.html.erb

# <% @results.each do |result| %>
#   <% if result.searchable_type = Movie %>
#   <p>By <% result.searchable.director.first_name%></p>
#   <% end %>
#   <h4><%= result.searchable.title %></h4>
#   <p><%= result.searchable.synopsis %></p>
# <% end %>