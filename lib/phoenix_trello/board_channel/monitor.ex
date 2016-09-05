defmodule PhoenixTrello.BoardChannel.Monitor do
  use GenServer

  #####
  # Client API

  def start_link(initial_state) do
   GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def user_joined(board, member) do
   GenServer.call(__MODULE__, {:user_joined, board, member})
  end

  def user_left(board, member) do
    GenServer.call(__MODULE__, {:user_left, board, member})
  end

  #####
  # Server callbacks

  def handle_call({:user_joined, board, member}, _from, state) do
    state = case Map.get(state, board) do
      nil ->
        state = state
        |> Map.put(board, [member])

        {:reply, [member], state}
      members ->
        state = state
        |> Map.put(board, Enum.uniq([member | members]))

        {:reply, Map.get(state, board), state}
    end
  end

  def handle_call({:user_left, board, user}, _from, state) do
      new_users = state
        |> Map.get(board)
        |> List.delete(user)

      state = state
        |> Map.update!(board, fn(_) -> new_users end)

      {:reply, new_users, state}
    end
end
