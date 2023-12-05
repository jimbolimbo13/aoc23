IO.puts("Advent of Code Day4")

defmodule Day4 do
  def load_file(f_name) do
    file_lines = String.split(File.read!(f_name), "\n")

    part1 = Enum.map(file_lines, fn x -> String.split(List.last(String.split(x ,":")), ["|", " "]) end )
    |> Enum.map(&count_pow/1)
    |> Enum.sum()

    #part2 =

    IO.puts("Day4 part1: #{part1}")
    #IO.puts("Day4 part2: #{part2}")
 end

  def count_pow(list) do
   int_list = Enum.reject(list, fn x -> x == "" end)

   diff = length(int_list) - length(Enum.uniq(int_list))
   case diff do
        0 -> 0
        _ -> Integer.pow(2,(diff - 1))
    end

   end

end

#file_name = "input-day4.txt"
file_name = "test-day4.txt"
Day4.load_file(file_name)
