defmodule ToyRobotTest do
  use ExUnit.Case
  doctest ToyRobot

  test "places the Toy Robot on the table in the default position" do
    assert ToyRobot.place == %ToyRobot.Position{x: 0, y: 0, facing: :north}
  end

  test "places the Toy Robot on the table in the specified position" do
    assert ToyRobot.place(1, 2, :south) == %ToyRobot.Position{x: 1, y: 2, facing: :south}
  end
end
