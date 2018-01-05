defmodule ToyRobot.OtpRobot do
  use GenServer

  def place do
    {:ok, state} = ToyRobot.place
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def report, do: GenServer.call(__MODULE__, :report)

  def move, do: GenServer.cast(__MODULE__, :move)
  def left, do: GenServer.cast(__MODULE__, :left)
  def right, do: GenServer.cast(__MODULE__, :right)

  def handle_call(:report, _from, current_state) do
    report = ToyRobot.report(current_state)
    {:reply, report, current_state}
  end

  def handle_cast(:move, current_state) do
    {:noreply, ToyRobot.move(current_state)}
  end

  def handle_cast(:left, current_state) do
    {:noreply, ToyRobot.left(current_state)}
  end

  def handle_cast(:right, current_state) do
    {:noreply, ToyRobot.right(current_state)}
  end
end
