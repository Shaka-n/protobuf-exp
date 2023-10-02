defmodule ProtobufExp.ExperimentSupervisor do
  use Supervisor
  alias ProtobufExp.PeriodicTask

  def start_link(init_arg)do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      PeriodicTask
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end

  def handle_call(:count_childre, _from, state) do
    {:reply, state, state}
  end
end
