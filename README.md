# ProtobufExp

The point of this project is to practice serializing with protocol buffers in an Elixir project.
I'm using proto3, because why not. 
I'm using protobuf over exprotobuf because the latter doesn't seem to be in active development.

Slight revision to the instructions from the [protobuf](https://github.com/elixir-protobuf/protobuf) package:

1. Download and install the procol buffer compiler (`protoc`). On MacOS, `brew install protoc`
  - Note: This package is not idempotent, so if you already have it the install will fail (probably around the symlink step)
2. Install the Elixir plugin for `protoc`, `protoc-gen-elixir`. Either add PATH=~/.mix/escripts:$PATH to your bash or zsh profile or, if you used asdf to install elixir, run asdf reshim and then verify that protoc-gen-elixir works:
  ```mix escript.install hex protobuf```
3. Create your `*.proto` file. (i.e. `helloworld.proto`). 
  - In my case I keep the proto files in their own directory: `lib/protobuf_exp/protos`
  - I also create an output folder for the generated Elixir modules: `lib/protobuf_exp/generated`
4. Generate Elixir code for your proto file...
  ```protoc --elixir_out="./lib/protobuf_exp/protos/" --proto_path="./lib/protobuf_exp/protos/" --elixir_opt=package_prefix=protobuf_exp.protos helloworld.proto```
    - The `protobuf` package has a bunch of optional flags. One that I think should be on by default is preserving prefixes. Who wants to top level namespace their serialization? Maybe I'm the weird one...               
...which will create an Elixir file (`*.pb.ex`) and module like so:
```defmodule Helloworld.HelloRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :name, 1, type: :string
end

defmodule Helloworld.HelloReply do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :message, 1, type: :string
end
```
5. Encode and Decode your data using structs:
```
struct = %Foo{a: 3.2, c: %Foo.Bar{}}
encoded = Foo.encode(struct)
struct = Foo.decode(encoded)
```



Useful Resources:
[protobuf](https://github.com/elixir-protobuf/protobuf)
[Elixir gRPC](https://github.com/elixir-grpc/grpc)
[gRPC](https://grpc.io/docs/what-is-grpc/introduction/)
[proto3 Reference Guide](https://protobuf.dev/programming-guides/proto3/)


To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
