ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Fantasygame.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Fantasygame.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Fantasygame.Repo)

