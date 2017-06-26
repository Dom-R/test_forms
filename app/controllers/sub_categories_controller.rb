class SubCategoriesController < ApplicationController
  # Admin page to manage a subcategory fields.
  def edit
    @sub_category = SubCategory.find(params[:id])
    @field = Field.new
    @field.sub_category_id = @sub_category.id

    # Array for options used in type dropdown
    @type_options = Field.type_options
  end

  # Method to make sure the routing is consistent
  # Example: /reformas-e-reparos/pintor is correct, but /reformsa-e-repaors/pintor is not
  def show
    category = Category.find_by(slug: params[:category_slug])
    @sub_category = SubCategory.find_by(slug: params[:slug], category_id: category)
  end
end
