class Category < ActiveRecord::Base
  has_many :sub_categories

  # Funcao removida devido a Rails > 4.0 usar require.permit Ex: params.require(:category).permit(:name, :slug)
  # attr_accessible :name, :slug
end
