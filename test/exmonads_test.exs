defmodule ExmonadsTest do
  use ExUnit.Case
  import Exmonads
  doctest Exmonads

  def divide_by(input, divisor) do
    try do
      {:ok, input / divisor}
    rescue
      _e in ArithmeticError -> {:error, "Divide by zero"}
    end
  end

  def add_by(input, more) do
    {:ok, input + more}
  end

  test "exmonads" do
    assert {:ok, 10} ~> divide_by(2) ~> add_by(1) == {:ok, 6.0}
    assert {:ok, 10} ~> add_by(1) ~> divide_by(2) == {:ok, 5.5}
    assert {:ok, 10} ~> divide_by(0) ~> add_by(1) == {:error, "Divide by zero"}
    assert {:error, 27} ~> divide_by(0) == {:error, 27}
    assert {:ok, 10} ~> (&({:ok, &1*2})).() == {:ok, 20}
  end

  '''
  test "best" do
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

    File.read("some_json_file.json")
    ~> Poison.decode
    ~> Dict.fetch("Peter")
  end
  '''
end
