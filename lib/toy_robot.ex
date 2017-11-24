defmodule ToyRobot do
  def place do
    %ToyRobot.Position{}
  end

  def place(x, y, facing) do
    %ToyRobot.Position{x: x, y: y, facing: facing}
  end

  def report(%ToyRobot.Position{x: x, y: y, facing: facing} = _robot) do
    {x, y, facing}
  end

  @directions_to_the_right %{north: :east, east: :south, south: :west, west: :north}
  def right(%ToyRobot.Position{facing: facing} = robot) do
    %ToyRobot.Position{robot | facing: @directions_to_the_right[facing]}
  end

  @directions_to_the_left Enum.map(@directions_to_the_right, fn {from, to} -> {to, from} end)
  def left(%ToyRobot.Position{facing: facing} = robot) do
    %ToyRobot.Position{robot | facing: @directions_to_the_left[facing]}
  end

  def move(%ToyRobot.Position{x: _, y: y, facing: :north} = robot) do
    %ToyRobot.Position{robot | y: y + 1}
  end

  def move(%ToyRobot.Position{x: x, y: _, facing: :east} = robot) do
    %ToyRobot.Position{robot | x: x + 1}
  end

  def move(%ToyRobot.Position{x: _, y: y, facing: :south} = robot) do
    %ToyRobot.Position{robot | y: y - 1}
  end

  def move(%ToyRobot.Position{x: x, y: _, facing: :west} = robot) do
    %ToyRobot.Position{robot | x: x - 1}
  end
end
