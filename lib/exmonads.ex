defmodule Exmonads do
  defmacro {:error, message} ~> _ do
    {:error, message}
  end
  defmacro {:ok, input} ~> {method, meta, args} do
    {method, meta, [input | args]}
  end
  defmacro left ~> right do
    quote do
      case unquote(left) do
        {:error, message} -> {:error, message}
        {:ok, value} -> {:ok, value} ~> unquote(right)
      end
    end
  end
end

defmodule Exmonads.Examples do
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
end
