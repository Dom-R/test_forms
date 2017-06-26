class FieldsController < ApplicationController
  include FieldsHelper

  # Method to delete a field
  def destroy
    @field = Field.find(params[:id])
    @field.destroy

    redirect_to edit_sub_category_path(@field.sub_category)
  end

  # Method to add a new field
  def create
    @sub_category = SubCategory.find(params[:sub_category_id])
    @field = Field.new(field_params)
    @field.sub_category_id = params[:sub_category_id]
    @field.save

    redirect_to edit_sub_category_path(@field.sub_category)
  end

  # Method to add new options to a checkbox field
  def edit
    @field = Field.find(params[:id])
    @field.values << params[:field][:val]
    @field.save

    redirect_to edit_sub_category_path(@field.sub_category)
  end

  # Method to delete a option from the checkbox options
  def destroy_value
    @field = Field.find(params[:id])
    @field.values.delete(params[:value])
    @field.save

    redirect_to edit_sub_category_path(@field.sub_category)
  end
end
