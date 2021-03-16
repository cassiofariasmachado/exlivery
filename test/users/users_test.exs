defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "when all params are valid, returns the user" do
      response = User.build("Cássio", "cassio@email.com", "99999999999", 25, "Rua dos Bobos")

      expected_response = {:ok, build(:user)}

      assert expected_response == response
    end

    test "when there are invalid params, return an error" do
      response = User.build("Cássio Jr", "cassio@email.com", "99999999999", 10, "Rua dos Bobos")

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end
  end
end
