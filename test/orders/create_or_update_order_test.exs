defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Orders.CreateOrUpdate

  describe "call/1" do
    setup %{} do
      Exlivery.start_agents()

      cpf = "12345678910"
      user = build(:user, cpf: cpf)

      UserAgent.save(user)

      item_one = %{
        category: :pizza,
        description: "Pizza de Peperoni",
        quantity: 1,
        unit_price: Decimal.new("35.00")
      }

      item_two = %{
        category: :pizza,
        description: "Pizza de Calbresa",
        quantity: 1,
        unit_price: Decimal.new("30.0")
      }

      {:ok, user_cpf: cpf, item_one: item_one, item_two: item_two}
    end

    test "when all params are valid, saves the order", %{
      user_cpf: user_cpf,
      item_one: item_one,
      item_two: item_two
    } do
      params = %{user_cpf: user_cpf, items: [item_one, item_two]}

      response = CreateOrUpdate.call(params)

      assert {:ok, _user} = response
    end

    test "when there is no user with the given cpf, returns an error", %{
      item_one: item_one,
      item_two: item_two
    } do
      params = %{user_cpf: "0000000000", items: [item_one, item_two]}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "User not found"}

      assert expected_response == response
    end

    test "when there are invalid items, returns an error", %{
      user_cpf: user_cpf,
      item_one: item_one,
      item_two: item_two
    } do
      params = %{user_cpf: user_cpf, items: [%{item_one | quantity: 0}, item_two]}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid items"}

      assert expected_response == response
    end

    test "when there are no items, returns an error", %{
      user_cpf: user_cpf
    } do
      params = %{user_cpf: user_cpf, items: []}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end
  end
end
