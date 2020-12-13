-module(day5).
-import(math,[pow/2]).
-export([read/1,solve/1]).

%%%%%%% READ AND PARSE THE INPUT 

map(F, List) ->
    [F(X) || X<-List].

read(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  string:tokens(erlang:binary_to_list(Binary), "\n").

%%%%%%%%% AUX
tobinarytuples(String, Acc) -> 
case String of
    [H|T]->
            if 
                (([H] == "B") or ([H] == "R")) -> NewAcc = Acc ++ "1";
                true -> NewAcc = Acc ++ "0"
            end,
            tobinarytuples(T,NewAcc);
    [] -> {
            string:substr(Acc,1,7),
            string:substr(Acc,8,3)
        }
end.

tobinarytuples(String) -> tobinarytuples(String,"").

binarytodecimal(Number) -> 
    Resverse = string:reverse(Number), 
    binarytodecimal(Resverse,0, 0).

binarytodecimal(Number, Index, Aux) ->
    case  Number of
        [H|T]-> if 
                    ([H] == "1") -> 
                        binarytodecimal(T, Index+1, Aux+pow(2,Index));
                    true -> 
                        binarytodecimal(T, Index+1, Aux)
                end;
        []-> Aux
    end.

binaryToDecimalTuple({N1,N2}) -> {binarytodecimal(N1), binarytodecimal(N2)}.

calculateID({Row,Column}) -> Row *8 + Column.

solve(List) -> map(fun(String)->calculateID(binaryToDecimalTuple(tobinarytuples(String))) end, List).


%%%%%%%%%%%%%% SOLVE 
%% c(day5).
%% L  =  day5:read("input.txt").
%% IDList = day5:solve(L).
%% lists:max(IDList)