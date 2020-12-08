-module(day2).
-export([split/1, valid_psswd_1/1,valid_psswd_2/1]).

%%%%%%% READ AND PARSE THE INPUT 
read(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    string:tokens(erlang:binary_to_list(Binary), "\n").

map(F, List) ->
    [F(X) || X<-List].

split(FileName) -> 
    A = read(FileName),
    map(fun(S) -> string:tokens(S, "-: ") end, A).

%%%%%%%%% AUX
contar(Char, String) -> string:len([X||X<- String,  Char == [X]]).

%%%%%%%%%%%%%%  POLICIES
policy1(Minimun, Maximun, Char, String) ->
    Ocurrence = contar(Char,String),
    ((Minimun =< Ocurrence)  and (Maximun >= Ocurrence)).

policy2(Pos1, Pos2, Char, String) ->
    A = (Char == [lists:nth(Pos1,String)]),
    B = (Char == [lists:nth(Pos2,String)]),
    (A and (not B)) or (B and (not A)).

%%%%%%%%%%%%%% SOLVE
                                   
valid_psswd([], Acc, Policy) -> Acc;
valid_psswd([[Arg1,Arg2,Char, String]|T] , Acc,Policy) ->  
    Policy_Result = Policy(erlang:list_to_integer(Arg1), erlang:list_to_integer(Arg2), Char, String),
    if 
        Policy_Result -> valid_psswd(T, Acc+1, Policy);
        true -> valid_psswd(T, Acc, Policy)
    end.

valid_psswd_1(L) -> valid_psswd(L,0, fun(Mn,Mx, Char,String) -> policy1(Mn,Mx, Char,String) end).
valid_psswd_2(L) -> valid_psswd(L,0, fun(Pos1,Pos2, Char,String) -> policy2(Pos1,Pos2, Char,String) end).