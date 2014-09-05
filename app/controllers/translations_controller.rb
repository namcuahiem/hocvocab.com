class TranslationsController < ApplicationController
  def index
  end

  def create
  	@translation = current_user.translations.new(translation_params)
  	if @translation.save
  		redirect_to @translation.post
  	end
  end

  def update

  end

  def destroy

  end

  def get
  	@post = Post.find(params[:post_id])
  	@exact_translations = @post.translations.where("start=? AND end=?",params[:start],params[:end])
  	if @exact_translations.any?
  		@related_translations = []
  	else
  		@related_translations = @post.translations.where("(start<=:startId AND end>=:startId) OR (start<=:endId AND end>=:endId)",{startId: params[:start], endId: params[:end]})
  	end
  end
end

private
	def translation_params
		params.require(:translation).permit(:post_id, :words, :start, :end, :meaning)
	end
