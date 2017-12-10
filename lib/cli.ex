defmodule ToyRobot.CLI do
  def main(args) do
    args |> parse_args |> process_args
  end

  def parse_args(args) do
    {params, _, _} =  OptionParser.parse(args, switches: [help: :boolean])
    params
  end

  def process_args([help: true]) do
    print_help_message()
  end

  def process_args(_) do
    IO.puts("Welcome to the Toy Robot simulator!")
    print_help_message()
    receive_command()
  end

  @commands %{
    "quit"   => "Quits the simulator",
    "place"  => "Places the Robot into X,Y facing F (Default is 0,0,North). " <>
                "Where facing is: north, west, south or east. " <>
                "Format: \"place [X,Y,F]\".",
    "report" => "The Toy Robot reports about its position",
    "left"   => "Rotates the robot to the left",
    "right"  => "Rotates the robot to the right",
    "move"   => "Moves the robot one position forward"
  }

  defp receive_command(robot \\ nil) do
    IO.gets("> ")
    |> String.trim
    |> String.downcase
    |> String.split(" ")
    |> execute_command(robot)
  end

  defp execute_command(["place"], _robot) do
    {:ok, robot} = ToyRobot.place
    robot |> receive_command
  end

  defp execute_command(["place" | params], _robot) do
    {x, y, facing} = process_place_params(params)

    case ToyRobot.place(x, y, facing) do
      {:ok, robot} ->
        receive_command(robot)
      {:failure, message} ->
        IO.puts message
        receive_command()
    end
  end

  defp execute_command(["left"], robot) do
    robot |> ToyRobot.left |> receive_command
  end

  defp execute_command(["right"], robot) do
    robot |> ToyRobot.right |> receive_command
  end

  defp execute_command(["move"], robot) do
    robot |> ToyRobot.move |> receive_command
  end

  defp execute_command(["report"], nil) do
    IO.puts "The robot has not been placed yet."
    receive_command()
  end

  defp execute_command(["report"], robot) do
    {x, y, facing} = robot |> ToyRobot.report
    IO.puts String.upcase("#{x},#{y},#{facing}")

    receive_command(robot)
  end

  defp execute_command(["quit"], _robot) do
    IO.puts "\nConnection lost"
  end

  defp execute_command(_unknown, robot) do
    IO.puts("\nInvalid command. I don't know what to do.")
    print_help_message()

    receive_command(robot)
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
