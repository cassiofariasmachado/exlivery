defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    setup %{} do
      OrderAgent.start_link(%{})

      :order
      |> build(user_cpf: "12345678910")
      |> OrderAgent.save()

      :order
      |> build(user_cpf: "10987654321")
      |> OrderAgent.save()

      :ok
    end

    test "creates the report file" do
      Report.create("report_test.csv")

      response = File.read!("report_test.csv")

      expected_response =
        "12345678910,pizza,1,35.5,76.50\n" <>
          "12345678910,japonesa,2,20.50,76.50\n" <>
          "10987654321,pizza,1,35.5,76.50\n" <>
          "10987654321,japonesa,2,20.50,76.50\n"

      assert expected_response == response
    end
  end
end
