IO.puts("Advent of Code Day1")

defmodule Day1 do
  def load_file(f_name) do
    file_lines = String.split(File.read!(f_name), "\n")

    first_int = Enum.map(file_lines, &find_nums/1)
    second_int = Enum.map(file_lines, &find_last_num/1 )


    totals = Enum.zip_with(first_int, second_int, fn x,y -> concat_ints(x,y) end)
    #Enum.map(totals, &IO.puts/1)
    part1 = Enum.reduce(totals, 0, fn x, acc -> x + acc end)

    totals2 = Enum.map(file_lines, &search_regex/1)
    # Enum.map(totals2, &IO.puts/1)
    part2 = Enum.reduce(totals2, 0, fn x, acc -> x + acc end)

    IO.puts("Part1: #{part1}")
    IO.puts("Part2: #{part2}")
  end

  def concat_ints(x,y) do
    {int, _blah} = Integer.parse( "#{x}#{y}" )
    int
  end

  def find_last_num(list) do
    find_nums(String.reverse(list))
  end

  def find_nums("") do
    0
  end

  def find_nums(line) do
    case Integer.parse(String.first(line)) do
      {int, _} -> int
      :error -> find_nums(String.slice(line, 1..String.length(line)))
    end
  end

  def search_regex("") do
    0
  end

  def search_regex(line) do
    # IO.puts(line)
    # all_ints = Regex.scan(~r/\d|one|two|three|four|five|six|seven|eight|nine/, line)
    # |> List.flatten()
    first_int = Regex.run(~r/\d|one|two|three|four|five|six|seven|eight|nine/, line)
    last_int = Regex.run(~r/\d|enin|thgie|neves|xis|evif|ruof|eerht|owt|eno/, String.reverse(line) )

    # IO.puts(List.first(all_ints))
    # IO.puts(List.last(all_ints))
    first = case Integer.parse(List.first(first_int)) do
              {int, _} -> int
              :error -> str_to_int(List.first(first_int))
            end
    last = case Integer.parse(List.first(last_int)) do
              {int, _} -> int
              :error -> str_to_int(String.reverse(List.first(last_int)))
            end
    # IO.puts(concat_ints(first,last))
    concat_ints(first,last)
  end

  def str_to_int(str) do
    case str do
      "one" -> 1
      "two" -> 2
      "three" -> 3
      "four" -> 4
      "five" -> 5
      "six" -> 6
      "seven" -> 7
      "eight" -> 8
      "nine" -> 9
    end
  end

end

file_name = "input-day1.txt"
#file_name = "test-day1.txt"
Day1.load_file(file_name)
