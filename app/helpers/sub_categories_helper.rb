module SubCategoriesHelper
  # Definicao dos parametros aceitos
  def subcategory_params
    params.require(:subcategory).permit(:name, :slug)
  end
end
