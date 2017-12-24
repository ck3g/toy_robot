defmodule ToyRobot.AgentRobot do
  def place do
    {:ok, state} = ToyRobot.place
    {:ok, pid} = Agent.start(fn -> state end, name: __MODULE__)
    pid
  end

  def move, do: Agent.update(__MODULE__, &(ToyRobot.move(&1)))

  def left, do: Agent.update(__MODULE__, &(ToyRobot.left(&1)))

  def right, do: Agent.update(__MODULE__, &(ToyRobot.right(&1)))

  def report do
    Agent.get(__MODULE__, &(&1)) |> ToyRobot.report
  end
end
