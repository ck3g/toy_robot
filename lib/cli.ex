defmodule ToyRobot.CLI do
  def main(_args) do
    IO.puts("Welcome to the Toy Robot simulator!")
    print_help_message()
    receive_command()
  end

  @commands %{
    "quit" => "Quits the simulator"
  }

  defp receive_command do
    IO.gets("\n> ")
    |> String.trim
    |> String.downcase
    |> execute_command
  end

  defp execute_command("quit") do
    IO.puts "\nConnection lost"
  end

  defp execute_command(_unknown) do
    IO.puts("\nInvalid command. I don't know what to do.")
    print_help_message()

    receive_command()
  end

  defp print_help_message do
    IO.puts("\nThe simulator supports following commands:\n")
    @commands
    |> Enum.map(fn({command, description}) -> IO.puts("  #{command} - #{description}") end)
  end
end
