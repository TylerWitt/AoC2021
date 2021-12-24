defmodule DiagnosticHelper do
  def epsilon_rate(digits, count) do
    digits
    |> Enum.reduce("", fn
      digit, acc when digit < count / 2 ->
        acc <> "1"
      _digit, acc ->
        acc <> "0"
    end)
    |> Integer.parse(2)
    |> elem(0)
  end

  def gamma_rate(digits, count) do
    digits
    |> Enum.reduce("", fn
      digit, acc when digit > count / 2 ->
        acc <> "1"
      _digit, acc ->
        acc <> "0"
    end)
    |> Integer.parse(2)
    |> elem(0)
  end
end

{raw_digits, count} =
  "input.txt"
  |> File.stream!()
  |> Stream.map(&String.trim/1)
  |> Stream.map(fn input ->
    input
    |> String.split("")
    |> Enum.reject(& &1 == "")
    |> Enum.map(&String.to_integer/1)
  end)
  |> Enum.reduce({[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 0}, fn [a1, b1, c1, d1, e1, f1, g1, h1, i1, j1, k1, l1], {[a2, b2, c2, d2, e2, f2, g2, h2, i2, j2, k2, l2], count} ->
    {[a1 + a2, b1 + b2, c1 + c2, d1 + d2, e1 + e2, f1 + f2, g1 + g2, h1 + h2, i1 + i2, j1 + j2, k1 + k2, l1 + l2], count + 1}
  end)

gamma = DiagnosticHelper.gamma_rate(raw_digits, count)
epsilon = DiagnosticHelper.epsilon_rate(raw_digits, count)

IO.inspect(gamma * epsilon)
