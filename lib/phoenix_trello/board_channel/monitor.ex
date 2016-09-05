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
end
