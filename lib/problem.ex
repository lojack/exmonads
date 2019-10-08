defmodule Problem do
  def parse_json do
    case File.read("some_json_file.json") do
      {:ok, contents} ->
        case Poison.decode(contents) do
          {:ok, json} ->
            case Dict.fetch(json, "some_key") do
              {:ok, data} -> {:ok, data}
              :error -> {:error, :key_not_found}
            end
          {:error, reason} -> {:error, reason}
        end
      {:error, reason} -> {:error, reason}
    end
  end
end
