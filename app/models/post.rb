class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true

	belongs_to :user
	has_many :taggings
	has_many :tags, through: :taggings
	has_many :translations

	#getter
	def tag_list
		self.tags.collect{|tag| tag.name}.join(', ')
	end

	#setter
	def tag_list=(string_name)
		names = string_name.split(',').collect{|name| name.strip.downcase }
		tagnames = names.collect{|name| Tag.find_or_create_by(name: name) }
		self.tags = tagnames
	end
end
