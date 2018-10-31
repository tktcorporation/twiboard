class HomeController < ApplicationController

  skip_before_action :require_sign_in!

  def top
    @board = Manager.all_board(params[:page])
    @genre_array = Manager.get_all_genre
  end

  def search
    @genre_array_plus = Manager.get_all_genre.unshift(["未選択", -1])
  end

end
