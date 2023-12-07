IO.puts("Advent of Code Day5")

defmodule Day5 do
  def load_file(f_name) do
    file_lines = String.split(File.read!(f_name), "\n\n")

    seeds = List.first(file_lines)
    |> parse_seeds()
    maps = Enum.map(tl(file_lines), &map_to_ranges/1)

    part1 = map_seeds(seeds, maps)
    |> Enum.min()

    #part2 =

    IO.puts("Day5 part1: #{part1}")
    #IO.puts("Day5 part2: #{part2}")
 end

  def parse_seeds(seed_str) do
   String.split(seed_str, ":")
   |> List.last()
   |> String.split(" ")
   |> Enum.reject(fn x -> x == "" end)
   |> Enum.map(fn x ->
     case Integer.parse(x) do
       {int, _} -> int
       :error -> nil
     end
   end)
  end

  def map_seeds(seeds, []) do
   seeds
  end

  def map_seeds(seeds, maps) do
   new_seeds = Enum.map(seeds, fn x -> map_seed(x, hd(maps)) end)
   map_seeds(new_seeds, tl(maps))
  end

  def map_seed(seed, map) do
   case Enum.find(map, fn x -> seed >= List.first(tl(x)) && seed <= List.first(tl(x))+List.last(tl(x)) end) do
     nil -> seed
     match -> List.first(match) + (seed - List.first(tl(match)))
   end
  end

  def map_to_ranges(map) do
   List.last(String.split(map, ":"))
   |> String.split("\n")
   |> Enum.reject(fn x -> x == "" end)
   |> Enum.map(fn x -> String.split(x, " ") end)
   |> Enum.map(&to_ints/1 )
  end

  def to_ints(str) do
   Enum.map(str, fn x ->
    case Integer.parse(x) do
            {int, _} -> int
        :error -> nil
        end
   end)
  end

end

file_name = "input-day5.txt"
#file_name = "test-day5.txt"
Day5.load_file(file_name)
