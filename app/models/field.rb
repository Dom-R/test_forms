class Field < ActiveRecord::Base
  belongs_to :sub_category

  # disable STI allowing me to use type as a column
  self.inheritance_column = nil

  # Necessário para poder guardar array na coluna values
  serialize :values, Array
end
