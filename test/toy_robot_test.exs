defmodule ToyRobotTest do
  use ExUnit.Case
  doctest ToyRobot

  test "rotates the robot to the right" do
    {:ok, robot} = ToyRobot.place(0, 0, :north)
    position = robot |> ToyRobot.right |> ToyRobot.report
    assert position == {0, 0, :east}

    position = robot |> ToyRobot.right |> ToyRobot.right |> ToyRobot.report
    assert position == {0, 0, :south}
  end

  test "rotates the robot to the left" do
    {:ok, robot} = ToyRobot.place(0, 0, :north)
    position = robot |> ToyRobot.left |> ToyRobot.report

    assert position == {0, 0, :west}
  end

  test "rotating the robot 3 times to the right is the same as rotate its to the left" do
    {:ok, robot} = ToyRobot.place(0, 0, :north)
    right_position = robot |> ToyRobot.right |> ToyRobot.right |> ToyRobot.right |> ToyRobot.report
    left_position = robot |> ToyRobot.left |> ToyRobot.report

    assert right_position == left_position
  end

  test "moving robot up if it is facing to the north" do
    {:ok, robot} = ToyRobot.place(0, 0, :north)
    position = robot |> ToyRobot.move |> ToyRobot.report

    assert position == {0, 1, :north}
  end

  test "moving robot right if it is facing to the east" do
    {:ok, robot} = ToyRobot.place(0, 0, :east)
    position = robot |> ToyRobot.move |> ToyRobot.report

    assert position == {1, 0, :east}
  end

  test "moving robot down if it is facing to the south" do
    {:ok, robot} = ToyRobot.place(4, 4, :south)
    position = robot |> ToyRobot.move |> ToyRobot.report

    assert position == {4, 3, :south}
  end

  test "moving robot left if it is facing to the west" do
    {:ok, robot} = ToyRobot.place(4, 4, :west)
    position = robot |> ToyRobot.move |> ToyRobot.report

    assert position == {3, 4, :west}
  end

  test "prevent the robot to fall going north" do
    {:ok, robot} = ToyRobot.place(4, 4, :north)
    position = robot |> ToyRobot.move |> ToyRobot.report

    assert position == {4, 4, :north}
  end

  test "prevent the robot to fall going east" do
    {:ok, robot} = ToyRobot.place(4, 4, :east)
    position = robot |> ToyRobot.move |> ToyRobot.report

    assert position == {4, 4, :east}
  end

  test "prevent the robot to fall going south" do
    {:ok, robot} = ToyRobot.place(0, 0, :south)
    position = robot |> ToyRobot.move |> ToyRobot.report

    assert position == {0, 0, :south}
  end

  test "prevent the robot to fall going west" do
    {:ok, robot} = ToyRobot.place(0, 0, :west)
    position = robot |> ToyRobot.move |> ToyRobot.report

    assert position == {0, 0, :west}
  end
end
