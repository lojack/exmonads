defmodule Exmonads do
  defmacro {:error, message} ~> _, do: {:error, message}

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
