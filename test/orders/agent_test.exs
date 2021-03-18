defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent

  describe "save/1" do
    setup %{} do
      OrderAgent.start_link(%{})

      :ok
    end

    test "saves the order" do
      order = build(:order)

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup %{} do
      OrderAgent.start_link(%{})
      :ok
    end

    test "when the order is found, returns the order" do
      order = build(:order)
      {:ok, uuid} = OrderAgent.save(order)

      response = OrderAgent.get(uuid)

      expected_response = {:ok, order}

      assert expected_response == response
    end

    test "when the order is not found, returns an error" do
      response = OrderAgent.get("00000000000")

      expected_response = {:error, "Order not found"}

      assert expected_response == response
    end
  end
end
