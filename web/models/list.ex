
defmodule PhoenixTrello.List do
  use PhoenixTrello.Web, :model

  alias PhoenixTrello.{Board}

  @derive {Poison.Encoder, only: [:id, :board_id, :name]}

  schema "lists" do
    field :name, :string
    belongs_to :board, Board

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
