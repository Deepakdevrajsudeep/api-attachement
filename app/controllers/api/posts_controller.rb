class Api::PostsController < ApplicationController
  def create
    post = Post.new(create_params)
    if post.save
      render json: success_json(post), status: :created
    else
      render json: error_json(post), status: :unprocessable_entity
    end
  end

  def show
    post = Post.find_by(id: params[:id])
    if post.present?
      render json: success_json(post), status: :ok
    else
      head :not_found
    end
  end

  def avatar
    post = Post.find_by(id: params[:id])
    if post&.avatar&.attached?
      redirect_to rails_blob_url(post.avatar)
    else
      head :not_found
    end
  end

private

  def create_params
    params.require(:post).permit(:title, :content, :avatar)
  end

  def success_json(post)
    {
      post: {
        id: post.id,
        title: post.title,
        content: post.content
      }
    }
  end

  def error_json(post)
    { errors: post.errors.full_messages }
  end
end

# curl --include --request POST http://localhost:3000/api/posts --form "post[title]=Test Post" --form "post[avatar]=@avatar.png"
# curl --include --request POST http://localhost:3000/api/posts --form "user[avatar]=@avatar.png"
# curl --head http://localhost:3000/api/posts/1/avatar