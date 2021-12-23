defmodule SubmarineNavigator do
  def input_to_commands(line) do
    [dir, num] = String.split(line, " ")
    {dir, String.to_integer(num)}
  end

  def command_to_coordinates({"forward", value}, {h_pos, depth}), do: {h_pos + value, depth}
  def command_to_coordinates({"up", value}, {h_pos, depth}), do: {h_pos, depth - value}
  def command_to_coordinates({"down", value}, {h_pos, depth}), do: {h_pos, depth + value}
end

{h_pos, depth} =
  "input.txt"
  |> File.stream!()
  |> Stream.map(&String.trim/1)
  |> Stream.map(&SubmarineNavigator.input_to_commands/1)
  |> Enum.reduce({0, 0}, &SubmarineNavigator.command_to_coordinates/2)

IO.inspect(h_pos * depth)
