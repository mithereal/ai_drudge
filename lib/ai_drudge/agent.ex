defmodule AiDrudge.Agent do

  defp query(statement) do
    "make me 2 arguments republican and democrat for the statement #{statement} what are the key points and which side has more support"
  end

  def request(message, model \\ "anthropic:claude-3-5-sonnet") do
    schema = [republican: [type: :string, required: true], democrat: [type: :string, required: true], key_points: [type: :list, required: true], support: [side: :string, required: true]]

    {:ok, response} =
      AgentObs.ReqLLM.trace_generate_object(
        model,
        [%{role: "user", content: message}],
        schema
      )

    ReqLLM.Response.object(response)
    #=> %{republican: "string", democrat: "string", key_points: [], support: "string"}
  end

  def run(statement) do
    query(statement) |> request()
  end
end
