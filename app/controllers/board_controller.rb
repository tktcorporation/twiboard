class BoardController < ApplicationController

  skip_before_action :require_sign_in!, only: [:board, :testboard, :testcreate, :search, :trend, :advanced_search]

  def search
    @genre_array_plus = Manager.get_all_genre.unshift(["未選択", -1])
    if params[:keyword].blank?
      @boards = Manager.board_search(params[:page], params[:keyword]).page(params[:page]).per(10)
    else
      texts = params[:keyword].split(/[[:blank:]]+/)
      @boards = []
      texts.each do |text|
        Manager.board_search(params[:page], text).each{|b| @boards.push(b)}
      end
      @boards = Manager.add_paginate(@boards, params[:page])
    end
  end

  def advanced_search
    @genre_array_plus = Manager.get_all_genre.unshift(["未選択", -1])
    if params[:board].blank?
      @boards = Manager.board_advanced_search(params[:page], params[:board], params[:genre]).page(params[:page]).per(10)
    else
      texts = params[:board].split(/[[:blank:]]+/)
      @boards = []
      texts.each do |text|
        Manager.board_advanced_search(params[:page], text, params[:genre]).each{|b| @boards.push(b)}
      end
      @boards = Manager.add_paginate(@boards, params[:page])
    end
  end

  def board
    @board = Board.find(params[:id])
    @board.access_count = @board.access_count + 1
    @board.save
    @genre = Genre.find(@board.genre).name
    @post = Post.where(board_id: params[:id])
    @image_url = Manager.image_url_array(@post)
    @username = Manager.username_array(@post)
    @participants = Manager.get_participants_name_img(params[:id])
    if @current_user
      @participating_boards = Manager.participating_boards(@current_user.id)
    end
    #これはParticipantモデルに書くべき? Manager.get_participants(params[:id]).user_id
  end

  #homeに移動させたい
  def trend
    @boards = Manager.ranking(params[:page])
  end

  def participating
    if @current_user
      @participating_boards = Manager.participating_boards(@current_user.id)
    end
  end

  def create
    board_id = params[:id]
    if params[:content] == ""
      flash[:notice] = "投稿内容を入力してください"
      redirect_to "/board/#{board_id}"
    else
      @post = Post.new(content: params[:content], board_id: board_id, user_id: @current_user.id)
      if @post.save
        Manager.add_posts_count(board_id)
        Manager.find_or_create_participant(board_id, @current_user.id)
        flash[:notice] = "投稿しました"
        redirect_to "/board/#{board_id}"
      else
        flash[:notice] = "投稿に失敗しました"
      end
    end
  end

  def new
    if params[:title] == ""
      flash[:notice] = "タイトルを入力してください"
      render "home/top"
    else
      @board = Board.new(title: params[:title], creater_id: @current_user.id, genre: params[:genre])
      if @board.save
        flash[:notice] = "新規板を作成しました"
        redirect_to "/board/#{@board.id}"
      else
        flash[:notice] = "投稿に失敗しました"
      end
    end
  end

  def testboard
    @board = Board.find(9)
    @post = Post.where(board_id: 9)
  end

  def testcreate
    @post = Post.new(content: params[:content], board_id: 9, user_id: 0)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to "/board/9"
    else
      flash[:notice] = "投稿に失敗しました"
    end
  end

  private
  def post_params
  end
end
