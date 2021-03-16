defmodule Exlivery.Users.User do
  @keys [:name, :email, :cpf, :age, :address]
  @enforce_keys @keys

  defstruct @keys

  def build(name, email, cpf, age, address)
      when is_bitstring(name) and is_bitstring(email) and is_bitstring(cpf) and age >= 18 do
    {:ok,
     %__MODULE__{
       name: name,
       email: email,
       cpf: cpf,
       age: age,
       address: address
     }}
  end

  def build(_name, _email, _cfp, _age, _address), do: {:error, "Invalid parameters"}
end
