defmodule PhoenixTrello.Board do
  use PhoenixTrello.Web, :model

  alias __MODULE__
  alias PhoenixTrello.{Repo, UserBoard, User, List, Card}

  schema "boards" do
    field :name, :string

    belongs_to :user, User
    has_many :lists, List
    has_many :user_boards, UserBoard
    has_many :members, through: [:user_boards, :user]

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
    cards_query = from c in Card, preload: [:members]
    lists_query = from l in List, preload: [cards: ^cards_query]

    from b in query, preload: [:user, :members, lists: ^lists_query]
  end
end

defimpl Poison.Encoder, for: PhoenixTrello.Board do
  def encode(model, options) do
    model
    |> Map.take([:id, :name, :user, :members, :lists])
    |> Poison.Encoder.encode(options)
  end
end
