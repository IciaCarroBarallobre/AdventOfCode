-module(day5).
-import(math,[pow/2]).
-export([read/1,toIDs/1, ourNumber/1]).

%%%%%%%%% READ AND PARSE THE INPUT 

map(F, List) -> [F(X) || X<-List].

read(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  string:tokens(erlang:binary_to_list(Binary), "\n").

%%%%%%%%% AUX

tobinarytuples(String) -> tobinarytuples(String,"").

tobinarytuples([], Acc) -> {string:substr(Acc,1,7),string:substr(Acc,8,3)};
tobinarytuples([H|T], Acc) -> 
    if 
        (([H] == "B") or ([H] == "R")) -> NewAcc = Acc ++ "1";
        true -> NewAcc = Acc ++ "0"
    end,
    tobinarytuples(T,NewAcc).


binarytodecimal(Number) -> 
    Resverse = string:reverse(Number), 
    binarytodecimal(Resverse,0, 0).

binarytodecimal([], _, Aux)-> Aux;
binarytodecimal([H|T], Index, Aux) ->
    if 
        ([H] == "1") -> 
            binarytodecimal(T, Index+1, Aux+pow(2,Index));
        true -> 
            binarytodecimal(T, Index+1, Aux)
    end.

binaryToDecimalTuple({N1,N2}) -> {binarytodecimal(N1), binarytodecimal(N2)}.

%%%%%%%%% SOLVE 

calculateID({Row,Column}) -> Row *8 + Column.

toIDs(List) -> map(fun(String)->calculateID(binaryToDecimalTuple(tobinarytuples(String))) end, List).

ourNumber([H1,H2|T]) ->
    if  
        (H1 == H2 - 2 ) -> H1+1; 
        true -> ourNumber([H2|T])
    end;
ourNumber(_) -> notfound.   

%%%%%%%%% Results:
%%
%% c(day5).
%% L  =  day5:read("input.txt").
%% IDList = day5:toIDs(L).
%% lists:max(IDList).
%% day5:ourNumber(lists:sort(IDList)).