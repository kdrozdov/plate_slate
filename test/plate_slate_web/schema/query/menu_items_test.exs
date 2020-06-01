defmodule PlateSlateWeb.Schema.Query.MenuItemsTest do
  use PlateSlateWeb.ConnCase, async: true

  setup do
    PlateSlate.Seeds.run()
  end

  @query """
  {
    menuItems {
      name
    }
  }
  """
  test "menuItems field returns menu items" do
    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert json_response(conn, 200) == %{
             "data" => %{
               "menuItems" => [
                 %{"name" => "Bánh mì"},
                 %{"name" => "Chocolate Milkshake"},
                 %{"name" => "Croque Monsieur"},
                 %{"name" => "French Fries"},
                 %{"name" => "Lemonade"},
                 %{"name" => "Masala Chai"},
                 %{"name" => "Muffuletta"},
                 %{"name" => "Papadum"},
                 %{"name" => "Pasta Salad"},
                 %{"name" => "Reuben"},
                 %{"name" => "Soft Drink"},
                 %{"name" => "Vada Pav"},
                 %{"name" => "Vanilla Milkshake"},
                 %{"name" => "Water"}
               ]
             }
           }
  end

  @query """
  query($filter: MenuItemFilter!) {
    menuItems(filter: $filter) {
      name
    }
  }
  """
  @variables %{filter: %{"name" => "reu"}}
  test "menuItems field returns menu items filtered by name" do
    response = get(build_conn(), "/api", query: @query, variables: @variables)

    assert json_response(response, 200) == %{
             "data" => %{
               "menuItems" => [
                 %{"name" => "Reuben"}
               ]
             }
           }
  end

  @query """
  query ($filter: MenuItemFilter!) {
    menuItems(filter: $filter) {
      name
    }
  }
  """
  @variables %{filter: %{"tag" => "Vegetarian", "category" => "Sandwiches"}}
  test "menuItems field returns menuItems, filtering with a literal" do
    response = get(build_conn(), "/api", query: @query, variables: @variables)

    assert %{
             "data" => %{"menuItems" => [%{"name" => "Vada Pav"}]}
           } == json_response(response, 200)
  end

  @query """
  query($order: SortOrder!) {
    menuItems(order: $order) {
      name
    }
  }
  """
  @variables %{order: "DESC"}
  test "menuItems field returns items descending using literals" do
    response = get(build_conn(), "/api", query: @query, variables: @variables)

    assert %{
             "data" => %{"menuItems" => [%{"name" => "Water"} | _]}
           } = json_response(response, 200)
  end

  @query """
  query ($filter: MenuItemFilter!) {
    menuItems(filter: $filter) {
      name,
      addedOn
    }
  }
  """
  @variables %{filter: %{"addedBefore" => "2017-01-20"}}
  test "menuItems filtered by custom scalar" do
    sides = PlateSlate.Repo.get_by!(PlateSlate.Menu.Category, name: "Sides")

    %PlateSlate.Menu.Item{
      name: "Garlic Fries",
      added_on: ~D[2017-01-01],
      price: 2.50,
      category: sides
    }
    |> PlateSlate.Repo.insert!()

    response = get(build_conn(), "/api", query: @query, variables: @variables)

    assert %{
             "data" => %{
               "menuItems" => [%{"name" => "Garlic Fries", "addedOn" => "2017-01-01"}]
             }
           } == json_response(response, 200)
  end
end
