class Api::PostsController < ApplicationController
   

  def index
      @posts = Post.all
      render json: @posts
  end

  def create
    post = Post.new(create_params)
    if post.save
      render json: success_json(post), status: :created
    else
      render json: error_json(post), status: :unprocessable_entity
    end
    create_thumbnail if post.avatar.attached?
  end

  def show
    post = Post.find_by(id: params[:id])
    if post.present?
      render json: success_json(post), status: :ok
    else
      head :not_found
    end
  end

   def update
      @post = Post.find(params[:id])
      if @post.update(create_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
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
    def avatar_thumbnail
        post = Post.find_by(id: params[:id])
        if post.nil?
          render json: { error: 'Post not found' }, status: :not_found
          elsif post.avatar_thumbnail.attached?
            send_data post.avatar_thumbnail.blob.download, type: post.avatar_thumbnail.blob.content_type, disposition: 'inline'
          else
            render json: { error: 'Avatar thumbnail not found' }, status: :not_found
        end
    end

  def create_thumbnail
    return unless avatar.attached?
    thumbnail = post.avatar.variant(resize: '100x100').processed
    post.avatar_thumbnail.attach(thumbnail)
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