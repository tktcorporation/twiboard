class User < ApplicationRecord

  require "digest/sha2"

  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash[:provider] #providerはどのサービスで認証したのかを見分けるもの
    uid = auth_hash[:uid]
    name = auth_hash[:info][:name]
    image_url = auth_hash[:info][:image]

    #find_or_create_by()は()の中の条件のものが見つければ取得し、なければ新しく作成するというメソッド
    if user = self.find_by(provider: provider,uid: uid)
      user.update_attributes(
        username: name,
        image_url: image_url
      )
      user
    else
      user = self.create(
        provider: provider,
        uid: uid,
        username: name,
        image_url: image_url
      )
    end
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end

end
