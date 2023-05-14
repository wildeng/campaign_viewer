# frozen_string_literal: true

class CreateCandidate < ActiveRecord::Migration[7.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.integer :score
      t.integer :uncounted_messages
      t.integer :campaign_id, foreign_key: true
      t.timestamps
    end
  end
end
