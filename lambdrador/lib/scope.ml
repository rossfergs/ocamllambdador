
module String_map = Map.Make(String)

type scope = 
  {inner_scope: Parse_node.block_node String_map.t; outer_scope: scope option}

let bind nis cs = 
  { inner_scope = nis; outer_scope = cs.outer_scope }

let rec get name scope = 
  try
    String_map.find name scope.inner_scope
  with Not_found ->
    match scope.outer_scope with
    | None -> raise (Error.InterpreterError ("Variable" ^ name ^ "not found in scope"))
    | Some s -> get name s