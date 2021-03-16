defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

  def user_factory do
    %User{
      name: "Cássio",
      email: "cassio@email.com",
      cpf: "99999999999",
      age: 25,
      address: "Rua dos Bobos"
    }
  end

  def item_factory do
    %Item{
      description: "Pizza de peperroni",
      category: :pizza,
      unit_price: Decimal.new("35.5"),
      quantity: 1
    }
  end

  def order_factory do
    %Order{
      user_cpf: "99999999999",
      delivery_address: "Rua dos Bobos",
      items: [
        build(:item),
        build(:item,
          description: "Temaki de atum",
          category: :japonesa,
          quantity: 2,
          unit_price: Decimal.new("20.50")
        )
      ],
      total_price: Decimal.new("76.50")
    }
  end
end
