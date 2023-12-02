IO.puts("Advent of Code Day2")

defmodule Day2 do
  def load_file(f_name) do
    file_lines = String.split(File.read!(f_name), "\n")

    part1 = Enum.map(file_lines, &valid_line/1)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
    #part2 =

    IO.puts("Day2 part1: #{part1}")
    #IO.puts("Day2 part2: #{part2}")
 end

  # def parse_line(line) do
  #  String.split(line, ":")
  #  |> List.last()
  #  |> String.split(";")
  # end

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

file_name = "input-day2.txt"
#file_name = "test-day2.txt"
Day2.load_file(file_name)
