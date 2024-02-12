class AddColumns < ActiveRecord::Migration[5.2]
  def change
   add_reference :attachments, :post, foreign_key: true
  end
end
