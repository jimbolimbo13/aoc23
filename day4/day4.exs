IO.puts("Advent of Code Day4")

defmodule Day4 do
  def load_file(f_name) do
    file_lines = String.split(File.read!(f_name), "\n")

    part1 = Enum.map(file_lines, fn x -> String.split(List.last(String.split(x ,":")), ["|", " "]) end )
    |> Enum.map(&count_pow/1)
    |> Enum.sum()
    IO.puts("Day4 part1: #{part1}")

    part2_map = Enum.map(file_lines, &part2_split/1)
    part2 = duplicate(part2_map)
    IO.puts("Day4 part2: #{part2}")
 end

  def count_pow(list) do
   int_list = Enum.reject(list, fn x -> x == "" end)

   diff = length(int_list) - length(Enum.uniq(int_list))
   case diff do
        0 -> 0
        _ -> Integer.pow(2,(diff - 1))
    end

   end

  def part2_split(line) do
   case String.split(line, ":") do
     [_card, draw] -> %{count: 1, draw: draw}
     [""] -> %{count: 0, draw: ""}
   end

  end

  def card_score(card_to_score) do
   card = Map.fetch!(card_to_score, :draw)
   int_list = String.split(card, ["|", " "])
   |> Enum.reject(fn x -> x == "" end)

   length(int_list) - length(Enum.uniq(int_list))
  end

  def add_count(card_map, count) do
   Map.update!(card_map, :count, fn x -> x + count end)
  end

  def duplicate([]) do
   0
  end

  def duplicate(all_lines) do
   [head | tail] = all_lines

   score = card_score(head)
   count = Map.fetch!(head, :count)
   tail = if score > 0 do
    to_add = Enum.take(tail, score)
    |> Enum.map(fn x -> add_count(x, count) end)
    remaining = Enum.take(tail, (score - length(tail)))

    List.flatten(to_add, remaining)
    else
      tail
   end
   count + duplicate(tail)
  end

 end

file_name = "input-day4.txt"
#file_name = "test-day4.txt"
Day4.load_file(file_name)
