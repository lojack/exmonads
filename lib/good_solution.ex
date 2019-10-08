defmodule GoodSolution do
  def parse_json do
    with {:ok, contents} <- File.read("some_json_file.json"),
         {:ok, json} <- Poison.decode(contents),
         {:ok, data} <- Dict.fetch(json, "some_key")
    do
      {:ok, data}
    else
      err -> err
    end
  end
end
