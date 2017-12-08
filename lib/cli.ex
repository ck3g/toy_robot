defmodule ToyRobot.CLI do
  def main(_args) do
    IO.puts("Welcome to the Toy Robot simulator!")
    print_help_message()
    receive_command()
  end

  @commands %{
    "quit" => "Quits the simulator",
    "place" => "format: \"place [X,Y,F]\". " <>
               "Places the Robot into X,Y facing F (Default is 0,0,North). " <>
               "Where facing is: north, west, south or east."
  }

  defp receive_command do
    IO.gets("> ")
    |> String.trim
    |> String.downcase
    |> String.split(" ")
    |> execute_command
  end

  defp execute_command(["place"]) do
    ToyRobot.place
    receive_command()
  end

  defp execute_command(["place" | params]) do
    {x, y, facing} = process_place_params(params)

    case ToyRobot.place(x, y, facing) do
      {:ok, _robot} ->
        receive_command()
      {:failure, message} ->
        IO.puts message
        receive_command()
    end
  end

  defp execute_command(["quit"]) do
    IO.puts "\nConnection lost"
  end

  defp execute_command(_unknown) do
    IO.puts("\nInvalid command. I don't know what to do.")
    print_help_message()

    receive_command()
  end

  defp process_place_params(params) do
    [x, y, facing] = params |> Enum.join("") |> String.split(",") |> Enum.map(&String.trim/1)
    {String.to_integer(x), String.to_integer(y), String.to_atom(facing)}
  end

  defp print_help_message do
    IO.puts("\nThe simulator supports following commands:\n")
    @commands
    |> Enum.map(fn({command, description}) -> IO.puts("  #{command} - #{description}") end)
    IO.puts("")
  end
end
