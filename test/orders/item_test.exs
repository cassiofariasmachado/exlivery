defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "when all params are valid, return an item" do
      response = Item.build("Pizza de peperroni", :pizza, "35.5", 1)

      expected_response = {:ok, build(:item)}

      assert expected_response == response
    end

    test "there is an invalid category, returns an error" do
      response = Item.build("Pizza de peperroni", :frutas, "35.5", 1)

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end

    test "there is an invalid price, returns an error" do
      response = Item.build("Pizza de peperroni", :pizza, "", 1)

      expected_response = {:error, "Invalid unit price"}

      assert expected_response == response
    end

    test "there is an invalid quantity, returns an error" do
      response = Item.build("Pizza de peperroni", :pizza, "35.5", 0)

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end
  end
end
