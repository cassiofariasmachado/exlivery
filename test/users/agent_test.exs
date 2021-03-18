defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "save/1" do
    setup %{} do
      UserAgent.start_link(%{})

      :ok
    end

    test "saves the user" do
      user = build(:user)

      assert :ok == UserAgent.save(user)
    end
  end

  describe "get/1" do
    setup %{} do
      UserAgent.start_link(%{})
      :ok
    end

    test "when the user is found, returns the user" do
      user = build(:user, cpf: "12345678910")
      UserAgent.save(user)

      response = UserAgent.get("12345678910")

      expected_response =
        {:ok,
         %User{
           address: "Rua dos Bobos",
           age: 25,
           cpf: "12345678910",
           email: "cassio@email.com",
           name: "Cássio"
         }}

      assert expected_response == response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("00000000000")

      expected_response = {:error, "User not found"}

      assert expected_response == response
    end
  end
end
