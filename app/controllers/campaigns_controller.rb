# frozen_string_literal: true

class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
  end

  def show
    @campaign = Campaign.find(params[:id])
    @candidates = @campaign.candidates
  end
end
