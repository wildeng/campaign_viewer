# frozen_string_literal: true

class Vote < ApplicationRecord
  enum :validity, %i[during pre post]
  belongs_to :campaign
end
