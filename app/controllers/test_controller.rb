class TestController < ApplicationController
  skip_before_action :require_sign_in!
  def board
    @board = Board.find(params[:id])
    @post = Post.where(board_id: params[:id])
  end
end
