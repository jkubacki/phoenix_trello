defmodule PhoenixTrello.Board do
  use PhoenixTrello.Web, :model

  alias __MODULE__

  @derive {Poison.Encoder, only: [:id, :name, :user]}

  schema "boards" do
    field :name, :string
    belongs_to :user, PhoenixTrello.User

    timestamps
  end

  @required_fields ~w(name user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def preload_all(query) do
    from b in query, preload: [:user]
  end
end
