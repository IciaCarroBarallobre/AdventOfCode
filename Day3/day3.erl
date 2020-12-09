-module(day3).
-export([read/1, move_and_check/3, next_row/1]).

%%%%%%%%%%%%%% READ THE LIST
read(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  string:tokens(erlang:binary_to_list(Binary), "\n").


move_and_check(Tree, Free, String) ->
    Fila = Tree+Free,    
    Len = string:length(String)+1,
    Pos = (Fila*3 + 1)   rem Len, 
    Item = lists:nth(Pos, String),
    case Item of
        35 -> {Tree +1,Free};
        46 -> {Tree,Free+1}; 
        _ -> {Tree,Free}
    end.

next_row([]) -> {error,0,0};
next_row([H|T]) -> next_row({0,0},  T).

next_row({Tree, Free}, []) -> {ok, Tree,Free};
next_row({Tree, Free}, [H|T]) ->  next_row(move_and_check(Tree, Free, H), T).

