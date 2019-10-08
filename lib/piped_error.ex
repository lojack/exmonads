defmodule PipedError do

  defmacro {:error, message} ~> _, do: {:error, message}

  defmacro {:ok, input} ~> {method, meta, args} do
    {method, meta, [input | args]}
  end

  defmacro left ~> right do
    quote do
      case unquote(left) do
        {:ok, value} ->
          {:ok, value} ~> unquote(right)
        {:error, message} ->
          {:error, message}
      end
    end
  end
end
