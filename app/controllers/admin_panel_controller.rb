class AdminPanelController < ApplicationController
  def index
    @categories = Category.all
  end
end
