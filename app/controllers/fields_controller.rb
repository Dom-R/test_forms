class FieldsController < ApplicationController
  include FieldsHelper
  
  def destroy
    @field = Field.find(params[:id])
    @field.destroy

    #flash.notice = "Field '#{@field.title}' deleted!"

    redirect_to edit_sub_category_path(@field.sub_category)
  end

  def create
    @sub_category = SubCategory.find(params[:sub_category_id])
    @field = Field.new(field_params)
    @field.sub_category_id = params[:sub_category_id]

    @field.save

    redirect_to edit_sub_category_path(@field.sub_category)
  end
end
