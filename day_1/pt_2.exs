"input.txt"
|> File.stream!()
|> Stream.map(&String.to_integer(String.trim(&1)))
|> Stream.chunk_every(3, 1)
|> Stream.map(&Enum.sum/1)
|> Stream.transform(0, fn
  val, 0 ->
    {[], val}
  val, acc ->
    if val > acc, do: {[val], val}, else: {[], val}
end)
|> Enum.count()
|> IO.inspect()
