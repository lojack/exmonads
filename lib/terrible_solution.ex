defmodule TerribleSolution do
  def parse_json do
    File.read("some_json_file.json")
    |> Poison.decode
    |> Dict.fetch("some_key")
  end
end
