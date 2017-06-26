require 'test_helper'

class FieldFlowsTest < ActionDispatch::IntegrationTest
  def setup
    Rails.application.load_seed
  end

  test "Render /:slug_categoria/:slug_subcategoria/ pages" do
    get "/reformas-e-reparos/pintor"
    assert_response :success
    assert_select "h2", "Pintor"
  end

  test "Create a new field of type text" do
    get "/admin/sub_categories/1/edit"
    assert_response :success
    assert_select "h2", "Formulário:"

    # Add a field through forms
    post "/admin/sub_categories/1/fields", field: {order: 1, title: "First", type: "text"}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "li", "Order: 1"
  end

  test "Create a new field of type checkbox" do
    get "/admin/sub_categories/1/edit"
    assert_response :success
    assert_select "h2", "Formulário:"

    # Add a field through forms
    post "/admin/sub_categories/1/fields", field: {order: 2, title: "Checkbox Field", type: "checkbox"}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "li", "Order: 2"
  end

  test "Create a new field of type checkbox and add a option" do
    get "/admin/sub_categories/1/edit"
    assert_response :success
    assert_select "h2", "Formulário:"

    # Add a field through forms
    post "/admin/sub_categories/1/fields", field: {order: 1, title: "First", type: "checkbox"}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "li", "Type: checkbox"

    # Add an option to the checkbox
    get "/admin/sub_categories/1/fields/1/edit", field: {val: "one"}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'ul.values' do
      assert_select "li", 2
    end
  end

  test "Create 100 fields" do
    get "/admin/sub_categories/1/edit"
    assert_response :success
    assert_select "h2", "Formulário:"

    1.upto(100) do |num|
      type = num % 2 == 0 ? "text" : "checkbox"
      # Add a field through forms
      post "/admin/sub_categories/1/fields", field: {order: num, title: "Field #{num}", type: type }
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_select "ul.fields li##{num}", "Order: #{num}"
    end
  end

  test "Create a field and delete it" do
    get "/admin/sub_categories/1/edit"
    assert_response :success
    assert_select "h2", "Formulário:"

    # Add a field through forms
    post "/admin/sub_categories/1/fields", field: {order: 1, title: "First", type: "text"}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "li#1", "Order: 1"

    # Send delete request to a field
    delete "/admin/sub_categories/1/fields/1"
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'ul.fields' do
      assert_select "li", 0
    end
  end

  test "Create a new field of type checkbox and add a option and delete it" do
    get "/admin/sub_categories/1/edit"
    assert_response :success
    assert_select "h2", "Formulário:"

    # Add a field through forms
    post "/admin/sub_categories/1/fields", sub_category_id: 1, field: {order: 1, title: "First", type: "checkbox"}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "li", "Type: checkbox"

    # Add an option to the checkbox
    get "/admin/sub_categories/1/fields/1/edit", field: {val: "one"}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "a[href=?]", "/admin/sub_categories/1/fields/1/destroy_value?value=one"

    # Send get request to funcion Field#destroy_value responsible to remove a option from the values of a checkbox
    get '/admin/sub_categories/1/fields/1/destroy_value?value=one'
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'ul.values' do
      assert_select "li", 1
    end
  end

  test "Create 100 options to a checkbox field" do
    get "/admin/sub_categories/1/edit"
    assert_response :success
    assert_select "h2", "Formulário:"

    # Add a field through forms
    post "/admin/sub_categories/1/fields", field: {order: 1, title: "First", type: "checkbox"}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "li", "Type: checkbox"

    1.upto(100) do |num|
      # Add an option to the checkbox
      get "/admin/sub_categories/1/fields/1/edit", field: {val: "#{num}"}
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_select 'ul.values' do
        assert_select "li", num + 1
      end
    end
  end

  test "Create 100 fields and see them on the show page" do
    get "/admin/sub_categories/1/edit"
    assert_response :success
    assert_select "h2", "Formulário:"

    1.upto(100) do |num|
      type = num % 2 == 0 ? "text" : "checkbox"
      # Add a field through forms
      post "/admin/sub_categories/1/fields", field: {order: num, title: "Field #{num}", type: type }
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_select "ul.fields li##{num}", "Order: #{num}"
    end

    get "/reformas-e-reparos/pintor"
    assert_response :success
    assert_select "h2", "Pintor"
    assert_select 'p', 101
  end

end
