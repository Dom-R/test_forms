class SubCategory < ActiveRecord::Base
  belongs_to :category
  has_many :fields

  # Funcao trocada devido a Rails > 4.0 usar require.permit Ex: params.require(:subcategory).permit(:name, :slug)
  # attr_accessible :name, :slug
  def subcategory_params
    params.require(:subcategory).permit(:name, :slug)
  end

end
