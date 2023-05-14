# frozen_string_literal: true

class Campaign < ApplicationRecord
  has_many :votes
  has_many :candidates

  def calculate_score
    candidates.each do |candidate|
      candidate.update(
        score: votes.where(choice: candidate.name, validity: :during).count
      )
    end
  end

  def calculate_uncounted_messages
    candidates.each do |candidate|
      candidate.update(
        uncounted_messages: votes.where(
          choice: candidate.name, validity: :pre
        ).or(Vote.where(choice: candidate.name, validity: :post)).count
      )
    end
  end
end
