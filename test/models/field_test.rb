require 'test_helper'

class FieldTest < ActiveSupport::TestCase
  # Defining a valid field
  def setup
    @field = Field.new(order: 1, title: "First Field", type: "text", values: [])
  end

  test "is field valid?" do
    assert @field.valid?
  end

  test "order is required" do
    @field.order = nil
    assert_not @field.valid?, "Order number was not filled"
  end

  test "order has to be bigger than 0" do
    @field.order = -1
    assert_not @field.valid?, "Order number is lower than 0"
  end

  test "title should be present" do
    @field.title = ""
    assert_not @field.valid?, "Title was not filled"
  end

  test "type should be present" do
    @field.type = ""
    assert_not @field.valid?, "Type was not selected"
  end

  test "type has to be either in type_options" do
    @field.type = "date"
    assert_not_includes Field.type_options, @field.type, "Type is not in Field.type_options"
  end

  test "values are only used on checkboxes" do
    #@field.values = ["foo", "bar"]
    #assert_not (false if @field.type != "checkbox" && @field.values != [], "Values not empty for type different than checkbox")
  end
end
