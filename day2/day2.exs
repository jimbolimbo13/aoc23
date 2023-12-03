IO.puts("Advent of Code Day2")

defmodule Day2Part1 do

  def load_file(f_name) do
    file_lines = String.split(File.read!(f_name), "\n")

    part1 = Enum.map(file_lines, &valid_line/1)
    |> Enum.reduce(0, fn x, acc -> x + acc end)

    IO.puts("Day2 part1: #{part1}")
 end


  def valid_line("") do
   0
  end

  def valid_line(line) do
   [game_str, cubes] = String.split(line, ":")
   {game_id, _rem} = String.split(game_str)
   |> List.last()
   |> Integer.parse()

   case valid_game(String.split(cubes, ";")) do
     true -> game_id
     false -> 0
   end

  end

  def valid_game(game) do
   Enum.map(game, fn x -> check_rounds(String.split(x, ",")) end)
   |> Enum.reduce(true, fn x, acc -> x && acc end)
  end

  def check_rounds(rounds) do
   Enum.map(rounds, &valid_round/1)
   |> Enum.reduce(true, fn x, acc -> x && acc end)
  end

  def valid_round(round) do
   [count, color] = String.split(round)
   case color do
       "blue" -> case Integer.parse(count) do
                                {int, _} -> int <= 14
                            end
        "green" -> case Integer.parse(count) do
                         {int, _} -> int <= 13
                       end
       "red" -> case Integer.parse(count) do
                             {int, _} -> int <= 12
                           end

     end
  end
end

defmodule Day2Part2 do

  def load_file(f_name) do
    file_lines = String.split(File.read!(f_name), "\n")

    part2 = Enum.map(file_lines, &count_line/1)
    |> Enum.reduce(0, fn x, acc -> x + acc end)

    IO.puts("Day2 part2: #{part2}")
 end

  def count_line("") do
   0
  end

  def count_line(line) do
   [_, cubes] = String.split(line, ":")
   rounds = String.split(cubes, [",", ";"])
   maxes = %{blue: 0, green: 0, red: 0}
   maxes = round_max(rounds, maxes)
   round_total(maxes)
  end

  def round_max([], maxes) do
   maxes
  end

  def round_max(rounds, maxes) do
   [round | tail] = rounds
   [count_str, color] = String.split(round)
   {count, _} = Integer.parse(count_str)
   maxes =  case String.trim(color) do
     "blue" -> case Map.fetch(maxes, :blue) do
                 {:ok, val} -> %{maxes | blue: max(val, count)}
                 :error -> Map.put(maxes, :blue, count)
               end

     "green" -> case Map.fetch(maxes, :green) do
                 {:ok, val} -> Map.put(maxes, :green, max(val, count) )
                 :error -> Map.put(maxes, :green, count)
                end
     "red" -> case Map.fetch(maxes, :red) do
                 {:ok, val} -> Map.put(maxes, :red, max(val, count) )
                 :error -> Map.put(maxes, :red, count)
                end
   end
   round_max(tail, maxes)
  end

  def round_total(maxes) do
   {:ok, red} = Map.fetch(maxes, :red)
   {:ok, blue} = Map.fetch(maxes, :blue)
   {:ok, green} = Map.fetch(maxes, :green)
   red * blue * green
  end

end

file_name = "input-day2.txt"
#file_name = "test-day2.txt"
Day2Part1.load_file(file_name)
Day2Part2.load_file(file_name)
