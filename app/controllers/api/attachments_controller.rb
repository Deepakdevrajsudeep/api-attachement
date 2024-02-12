class Api::AttachmentsController < ApplicationController
	def index
	    @attachments = Attachment.paginate(page: params[:page], per_page: 2) 
		  @attachments.each do |attachment|
	      attachment.try(:thumbnail).attach_data if params[:show_thumbnails]
	  end
	end

   def show 

   end 
end
