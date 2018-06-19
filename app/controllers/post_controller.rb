class PostController < ApplicationController
  #액션
  def index
    @posts=Post.all
  end

  def new
  end

  def create
    #1.
    post=Post.create(title: params[:title], body: params[:body])
    #텍스트 안에 변수를 넣을 때 (textinterpolation)
    # 반드시 ""로 해줘야함
    redirect_to "/post/#{post.id}"
    #1-1
    # Post.create(:title => params[:title], :body => params[:body] )
    # #2.
    # post = Post.new
    # post.title = params[:title]
    # post.body = params[:body]
    # post.save
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    #view파일 없이 삭제
    post=Post.find(params[:id])
    post.destroy
    #root page로 이동
    redirect_to '/'
  end

end
