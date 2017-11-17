defmodule ToyRobotTest do
  use ExUnit.Case
  doctest ToyRobot

  test "places the Toy Robot on the table in the default position" do
    assert ToyRobot.place == %ToyRobot.Position{x: 0, y: 0, facing: :north}
  end

  test "places the Toy Robot on the table in the specified position" do
    assert ToyRobot.place(1, 2, :south) == %ToyRobot.Position{x: 1, y: 2, facing: :south}
  end

  test "provides the report of the robot's position" do
    robot = ToyRobot.place(2, 3, :west)
    assert ToyRobot.report(robot) == {2, 3, :west}
  end

  test "rotates the robot to the right" do
    position = ToyRobot.place(0, 0, :north)
               |> ToyRobot.right
               |> ToyRobot.report

    assert position == {0, 0, :east}

    position = ToyRobot.place(0, 0, :north)
               |> ToyRobot.right
               |> ToyRobot.right
               |> ToyRobot.report

    assert position == {0, 0, :south}
  end

  test "rotates the robot to the left" do
    position = ToyRobot.place(0, 0, :north)
               |> ToyRobot.left
               |> ToyRobot.report

    assert position == {0, 0, :west}
  end

  test "rotating the robot 3 times to the right is the same as rotate its to the left" do
    right_position = ToyRobot.place(0, 0, :north)
                     |> ToyRobot.right
                     |> ToyRobot.right
                     |> ToyRobot.right
                     |> ToyRobot.report

    left_position =  ToyRobot.place(0, 0, :north)
                     |> ToyRobot.left
                     |> ToyRobot.report

    assert right_position == left_position
  end
end
