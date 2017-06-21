class Category < ActiveRecord::Base
  has_many :sub_categories

  # Funcao trocada devido a Rails > 4.0 usar require.permit Ex: params.require(:category).permit(:name, :slug)
  # attr_accessible :name, :slug
  def category_params
    params.require(:category).permit(:name, :slug)
  end
end
