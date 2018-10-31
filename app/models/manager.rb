class Manager
  PER = 8
  def self.image_url_array(post_array)
    image_url_array = []
    post_array.each do |post|
      image_url_array.push(User.find(post.user_id).image_url.sub(/http/, 'https'))
    end
    image_url_array
  end

  def self.username_array(post_array)
    username_array = []
    post_array.each do |post|
      username_array.push(User.find(post.user_id).username)
    end
    username_array
  end

  def self.ranking(page)
    Board.order(number_of_posts: :desc).limit(30).page(page).per(10)
  end

  def self.all_board(page)
    Board.order(created_at: :desc).page(page).per(10)
  end

  def self.board_search(page, text)
    text.blank? ? Board.order(created_at: :desc) : Board.where('lower(title) LIKE(?)', "%#{text}%")
  end

  def self.board_advanced_search(page, title, genre_id)
    array = [title, genre_id]
    if array[0].blank? && array[1] == "-1"
      #両方未指定
      Board.order(created_at: :desc)
    elsif array[0].blank? && array[1] != "-1"
      #ジャンルのみで検索
      Board.where('genre = ?', genre_id)
    elsif !array[0].blank? && array[1] == "-1"
      #タイトルのみで検索
      Board.where('lower(title) LIKE(?)', "%#{title}%")
    else
      #タイトルとジャンルで検索
      Board.where('lower(title) LIKE(?) AND genre = ?', "%#{title}%", genre_id)
    end
  end

  def self.get_all_genre
    Genre.all.map{|genre| [genre.name, genre.id]}
  end

  def self.get_participants(board_id)
    Participant.where(board_id: board_id)
  end

  def self.get_participants_name_img(board_id)
    profile_array = []
    user_array = self.get_participants(board_id)
    user_array.each do |userp|
      user = User.find(userp.user_id)
      array = [user.username, user.image_url.sub(/http/, 'https')]
      profile_array.push(array)
    end
    profile_array
  end

  def self.find_or_create_participant(board_id, user_id)
    array = Participant.where(board_id: board_id).pluck(:user_id)
    if !array.include?(user_id)
      participant = Participant.new(board_id: board_id, user_id: user_id)
      participant.save
      return 0
    else
      return true
    end
  end

  def self.participating_boards(user_id)
    id_array = Participant.where(user_id: user_id).pluck(:board_id)
    boards_array = []
    id_array.each do |board_id|
     boards_array.push(Board.find(board_id))
    end
    boards_array
  end

  def self.add_paginate(array, page)
    result = Kaminari.paginate_array(array).page(page).per(10)
    result
  end

  def self.add_posts_count(board_id)
    board = Board.find(board_id)
    board.number_of_posts = board.number_of_posts + 1
    board.save
  end

end
