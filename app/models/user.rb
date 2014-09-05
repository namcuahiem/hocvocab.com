class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :posts
   has_many :translations

   has_attached_file :image
   validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
