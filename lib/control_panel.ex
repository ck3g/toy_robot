defmodule ToyRobot.ControlPanel do
  use Supervisor

  def deploy_robot do
    Agent.start_link(fn -> nil end, name: :robot_state_repository)
    Supervisor.start_link(__MODULE__, :ok, [])
  end

  def init(:ok) do
    children = [ToyRobot.OtpRobot]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
