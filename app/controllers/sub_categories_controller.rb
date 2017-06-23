class SubCategoriesController < ApplicationController
  def edit
    @sub_category = SubCategory.find(params[:id])
    @field = Field.new
    @field.sub_category_id = @sub_category.id

    # Array for options used in type dropdown
    @type_options = [['Text', 'text'], ['Checkbox', 'checkbox']]
  end
end
