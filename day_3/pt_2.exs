defmodule DiagnosticHelper do
  def find_co2_rating(input) do
    walk_values(input, :down)
  end

  def find_oxy_rating(input) do
    walk_values(input, :up)
  end

  defp walk_values(input, dir) do
    {rating, remainder} = do_walk(input, dir, "")

    rating = concat_remainder(rating, remainder)

    {value, _remainder} = Integer.parse(rating, 2)
    value
  end

  defp concat_remainder(rating, []), do: rating

  defp concat_remainder(rating, remainder) do
    rating <> Enum.join(remainder)
  end

  defp do_walk([input], _dir, rating) when is_list(input) do
    {rating, input}
  end

  defp do_walk(input, dir, rating) do
    filter_value = filter_value(input, dir)

    input
    |> Enum.filter(fn [first | _rest] ->
      first == filter_value
    end)
    |> Enum.map(fn [_first | rest] -> rest end)
    |> do_walk(dir, rating <> to_string(filter_value))
  end

  defp filter_value(input, :down) do
    case parse_first(input) do
      {val, count} when val >= (count / 2) ->
        0
      _ ->
        1
    end
  end

  defp filter_value(input, :up) do
    case parse_first(input) do
      {val, count} when val >= (count / 2) ->
        1
      _ ->
        0
    end
  end

  defp parse_first(input) do
    Enum.reduce(input, {0, 0}, fn [first_digit | _other_digits], {digit_acc, count} ->
      {first_digit + digit_acc, count + 1}
    end)
  end
end

input =
  "input.txt"
  |> File.stream!()
  |> Stream.map(&String.trim/1)
  |> Stream.map(fn input ->
    input
    |> String.split("")
    |> Enum.reject(& &1 == "")
    |> Enum.map(&String.to_integer/1)
  end)
  |> Enum.to_list()

oxy = DiagnosticHelper.find_oxy_rating(input)
co2 = DiagnosticHelper.find_co2_rating(input)

IO.inspect(oxy * co2)
