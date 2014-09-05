class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :correct_user!, only: [:edit, :destroy, :update]

  def index
    @posts = Post.all   
  end  

  def show
  	@post = Post.find(params[:id])
    @user = @post.user
    @translations = @post.translations
    @translation = Translation.new
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.content = to_html(post_params[:content])
    if @post.save
      flash[:success] = "Post succesfully"
      redirect_to @post
    else
      flash.now[:error] = "Something went wrong, please post again"
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  private
    def post_params
      params.require(:post).permit(:title,:content,:tag_list)
    end

    def correct_user!
      if current_user.id != Post.find(params[:id]).user_id
        redirect_to root_path
      end
    end
end

def to_html(content)
  #sanitize: remove script from html
  content = content.gsub(/(<.*?>)/, '')
  #convert newline to br tag
  content = content.gsub(/\n/, '<br/>').html_safe
  #convert to span text
  id=0
  content = content.split(' ').collect do |word| 
    "<span class='word' id='w" +"#{id=id+1}"+"'>"+word+"</span>"+"<span class='word' id='w" +"#{id=id+1}"+"'> </span>"
  end.join('')
end

