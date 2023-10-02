defmodule ProtobufExp.PeriodicTask do
  alias ProtobufExp.Protos.Helloworld.{HelloReply, HelloRequest}
  use GenServer

  @interval 5 * 1000

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(thoughts) do
    :timer.send_interval(@interval, :think)
    :timer.send_interval(@interval * 2, :speak)
    {:ok, thoughts}
  end

  @impl true
  def handle_call(:list, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call(:speak, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_cast(:think, state) do
    {:noreply, state}
  end

  @impl true
  def handle_info(:speak, [head | tail]) do
    decoded = HelloRequest.decode(head)
    IO.inspect(decoded)
    {:noreply, tail}
  end

  @impl true
  def handle_info(:think, state) do
    IO.inspect(state)
    possible_thoughts = ["I'm Hungry", "Why do I live?", "Why are we still here, just to suffer?", "Life is a joy"]
    # Generate a new thought
    random_thought = Enum.random(possible_thoughts)
    encoded_thought = Protobuf.encode(%HelloRequest{name: random_thought})

    {:noreply, [encoded_thought | state]}
  end
end
