# Exmonads

This is a toy implementation of the error monad* in elixir, with a few examples of things that can be done to "spice" up your code

\* Using the term monad loosely, elixir isn't a typed language so monads aren't real

## The problem

``` elixir
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
```

Well, thats pretty nasty... there has to be a better way

## How elixir developers typically handle errors
[Good Example](lib/good_solution.ex)

``` elixir
with {:ok, contents} <- File.read("some_json_file.json"),
     {:ok, json} <- Poison.decode(contents),
     {:ok, data} <- Dict.fetch(json, "some_key")
do
  {:ok, data}
else
   err -> err
end
```

This is the common approach to handle this deep nesting. It's built-in and sort of built for this,
but I wonder if we can take this any further...

## Better solution
[Better Example](lib/better_solution.ex)

``` elixir
File.read("some_json_file.json")
|> maybe_run(&Poison.decode/1)
|> maybe_run(&(Dict.fetch(&1, "some_key")))
```

`maybe_run` essentially executes the function if its `{:ok, _}`, otherwise carries the error forward.
More terse than the previous example, but not necessarily cleaner

## Best Solution
[Best Example](lib/best_solution.ex)

``` elixir
File.read("some_json_file.json")
~> Poison.decode
~> Dict.fetch("some_key")
```

Elixir provides a handful of unused in-place operators that aren't used (this list is hardcoded),
in this case we use the `~>` operator and use some metaprogramming to implement what we're doing in the previous example

## Never do this in real code
### Seriously, dont
[Terrible Example](lib/terrible_solution.ex)

``` elixir
File.read("some_json_file.json")
|> Poison.decode
|> Dict.fetch("some_key")
```

WTF? How are we not handling errors? This should blow up! We can actually overload existing operators.
We're using some metapgrogramming magic to load everything _except_ for `|>` from elixir core,
which makes it available to redefine
