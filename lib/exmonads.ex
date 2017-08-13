defmodule Exmonads do
  def bind({:error, _} = error, _), do: error
  def bind({:ok, value}, fun) do
    fun.(value)
  end

  def {:error, message} ~> _, do: {:error, message}
  def {:ok, value} ~> fun do
    fun.(value)
  end
end

defmodule Exmonads.Examples do
  def divide_by(value) do
    fn(y) ->
      try do
        {:ok, y / value}
      rescue
        _e in ArithmeticError -> {:error, "Divide by zero"}
      end
    end
  end
end
