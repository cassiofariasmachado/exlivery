defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup %{} do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{
        name: "Cássio",
        address: "Rua dos Bobos",
        email: "cassio@email.com",
        cpf: "12345678910",
        age: 24
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, "User created or updated successfully"}

      assert expected_response == response
    end

    test "when thera are params invalid, returns an error" do
      params = %{
        name: "Cássio",
        address: "Rua dos Bobos",
        email: "cassio@email.com",
        cpf: "12345678910",
        age: 10
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end
  end
end
