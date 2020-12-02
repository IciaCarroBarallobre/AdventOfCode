-module(day1).
-export([solve_half1/1,solve_half2/1]).

%%%%%%%%%%%%%% AUX
read(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    string:tokens(erlang:binary_to_list(Binary), "\n").

to_list(String_L) -> [begin {Int, _} = string:to_integer(X), Int end || X <- String_L].


%%%%%%%%%%%%%% Solve part 1
half1(L) ->  [X * Y || X <- L, Y <- L, X+Y == 2020].

solve_half1(FileName) ->
    half1(to_list(read(FileName))).

%%%%%%%%%%%%%% Solve part 2
half2(L) -> [X * Y * Z || X <- L, Y <- L, Z <- L, X+Y+Z == 2020].

solve_half2(FileName) ->
    half2(to_list(read(FileName))).


