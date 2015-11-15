class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
    end

    add_reference :messages, :contact, index: true
  end
end

