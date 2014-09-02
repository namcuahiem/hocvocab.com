class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :correct_user!, only: [:edit, :destroy, :update]

  def index
    @posts = Post.all   
  end  

  def show
  	@post = Post.find(params[:id])
    @user = @post.user
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.create(post_params)
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


