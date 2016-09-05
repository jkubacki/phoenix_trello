defmodule PhoenixTrello.BoardChannel.Monitor do
  use GenServer

  #####
  # Client API

  def start_link(initial_state) do
   GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end
end
