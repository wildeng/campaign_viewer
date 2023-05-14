# # frozen_string_literal: true

class CreateCampaign < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.timestamps
    end
  end
end
