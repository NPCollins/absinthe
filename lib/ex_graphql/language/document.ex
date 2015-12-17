defmodule ExGraphQL.Language.Document do

  @type t :: %{definitions: [ExGraphQL.Language.Node.t], loc: ExGraphQL.Language.loc_t}
  defstruct definitions: [], loc: %{start: nil}

  @spec fragments_by_name(ExGraphQL.Language.Document.t) :: %{binary => ExGraphQL.Language.FragmentDefinition.t}
  def fragments_by_name(%{definitions: definitions}) do
    definitions
    |> Enum.reduce(%{}, fn (statement, memo) ->
      case statement do
        %ExGraphQL.Language.FragmentDefinition{} ->
          memo |> Map.put(statement.name, statement)
        _ ->
          memo
      end
    end)
  end

  defimpl ExGraphQL.Language.Node do
    def children(%{definitions: definitions}), do: definitions
  end

end
