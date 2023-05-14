# # frozen_string_literal: true

class CreateVote < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.string :choice
      t.integer :validity
      t.integer :campaign_id, foreign_key: true
      t.timestamps
    end
  end
end
