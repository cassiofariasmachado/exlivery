defmodule Exlivery do
  alias Exlivery.Orders.CreateOrUpdate, as: CreateOrUpdateOrder
  alias Exlivery.Users.CreateOrUpdate, as: CreateOrUpdateUser
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Orders.Agent, as: OrderAgent

  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call
  defdelegate create_or_update_order(params), to: CreateOrUpdateOrder, as: :call

  def start_agents() do
    UserAgent.start_link(%{})
    OrderAgent.start_link(%{})
  end
end
