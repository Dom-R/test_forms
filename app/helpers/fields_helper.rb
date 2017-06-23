module FieldsHelper
  # Definicao dos parametros aceitos
  def field_params
    params.require(:field).permit(:order, :title, :type, :values)
  end
end
