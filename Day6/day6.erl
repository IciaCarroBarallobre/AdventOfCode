-module(day6).
-export([read/1,yes_by_group_1/1,yes_by_group_2/1]).

%%%%%%% READ AND PARSE THE INPUT 

map(F, List) ->
    [F(X) || X<-List].

read(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    Groups = map(fun(A)->erlang:binary_to_list(A) end, re:split(erlang:binary_to_list(Binary),"\n\n")),
    map(fun(L) -> string:lexemes(L, "\n") end, Groups).

%%%%%%%%% AUX
remove_dups([])    -> [];
remove_dups([H|T]) -> [H | [X || X <- remove_dups(T), X /= H]].

%%%%%%%%%%%%%% SOLVE 
ocurrences(String, C) ->
    Result = string:find(String, C),
    if 
        (Result  == nomatch) -> "";
        true -> C
    end.

all_contains_C(C,L, Response)-> 
    case L of
        [H|T] -> Result =  0 < string:len(ocurrences(H,C)),
                 all_contains_C(C, T, Response and Result);
        [] -> Response
    end.
    
contains(String,List, Result)-> 
    case String of
        [H|T] -> Guard = all_contains_C([H], List,true), 
                if 
                    Guard  -> contains(T, List, Result ++ [H]);
                    true -> Result, contains(T, List, Result)
                end;
        [] -> Result    
    end.

policy1(H)->
    remove_dups(string:join(H, "")).

policy2([H|T]) ->  contains(H, T,"").
    
yes_by_group(L,Acc, Policy)-> 
    case L of
        [H|T] -> yes_by_group(T,Acc+string:length(Policy(H)),Policy);
        [] -> Acc
    end.

yes_by_group_1(L)-> 
    yes_by_group(L,0, fun (H) -> policy1(H) end).                                 

yes_by_group_2(L)-> 
    yes_by_group(L,0, fun (H) -> policy2(H) end).
