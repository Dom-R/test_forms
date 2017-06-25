class Field < ActiveRecord::Base
  belongs_to :sub_category

  # disable STI allowing me to use type as a column
  self.inheritance_column = nil

  # Necessary to store array in column: values
  serialize :values, Array

  # Order validation
  validates_numericality_of :order, :only_integer => true, :greater_than_or_equal_to => 0
  validates :title, presence: true
  validates :type, presence: true
  #validates_presence_of :values, :unless => :type = "text"

  # List of types
  @@type_options = ['text', 'checkbox']

  def self.type_options
    @@type_options
  end
end
