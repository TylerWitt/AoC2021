"input.txt"
|> File.stream!()
|> Stream.map(&String.to_integer(String.trim(&1)))
|> Stream.transform(0, fn
  val, 0 ->
    {[], val}
  val, acc ->
    if val > acc, do: {[val], val}, else: {[], val}
end)
|> Enum.count()
|> IO.inspect()
