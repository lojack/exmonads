defmodule BetterSolution do
  def parse_json do
    File.read("some_json_file.json")
    |> maybe_run(&Poison.decode/1)
    |> maybe_run(&(Dict.fetch(&1, "some_key")))
  end

  defp maybe_run({:error, _} = error, _fun), do: error
  defp maybe_run({:ok, value}, fun) do
    fun.(value)
  end
end
