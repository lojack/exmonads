defmodule TerribleSolution do
  use PipeOperator
  def parse_json do
    File.read("some_json_file.json")
    |> Poison.decode
    |> Dict.fetch("some_key")
  end
end
