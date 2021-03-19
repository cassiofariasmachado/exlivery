defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.{Order, Item}

  def create(file_name \\ "report.csv") do
    order_list = build_order_list()

    File.write!(file_name, order_list)
  end

  defp build_order_list() do
    OrderAgent.get_all()
    |> Map.values()
    |> Enum.flat_map(fn order -> order_string(order) end)
  end

  defp order_string(%Order{user_cpf: cpf, items: items, total_price: total_price}) do
    items
    |> Enum.map(fn item -> order_string(cpf, total_price, item) end)
  end

  defp order_string(cpf, total_price, item) do
    item_string =
      item
      |> item_string()

    "#{cpf},#{item_string},#{total_price}\n"
  end

  defp item_string(%Item{category: category, quantity: quantity, unit_price: unit_price}) do
    "#{category},#{quantity},#{unit_price}"
  end
end
