-module(day2).
-export([split/1, validate_psswd_1/1,validate_psswd_2/1,policy2/4]).

%%%%%%%%%%%%%% READ THE LIST 
read(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    string:tokens(erlang:binary_to_list(Binary), "\n").


split(FileName) -> 
    A = read(FileName),
    map(fun(S) -> string:tokens(S, "-: ") end, A).

map(F, List) ->
    [F(X) || X<-List].

%%%%%%%%%%%%%% AUX

contar(Str, String) -> string:len([X||X<- String,  Str == [X]]).

policy1(Minimun, Maximun, Letra, String) ->
    Ocurrence = contar(Letra,String),
    ((Minimun =< Ocurrence)  and (Maximun >= Ocurrence)).

policy2(Pos1, Pos2, Letra, String) ->
    A = (Letra == [lists:nth(Pos1,String)]),
    B = (Letra == [lists:nth(Pos2,String)]),
    (A and (not B)) or (B and (not A)).

%%%%%%%%%%%%%% Solve
                                   
validate_psswd([], Acc, Policy) -> Acc;
validate_psswd([[Arg1,Arg2,Letra, String]|T] , Acc,Policy) ->  
    Arg_aux_1 = erlang:list_to_integer(Arg1), 
    Arg_aux_2 = erlang:list_to_integer(Arg2),
    Policy_Result = Policy(Arg_aux_1,Arg_aux_2, Letra, String),
    if 
        Policy_Result -> validate_psswd(T, Acc+1, Policy);
        true -> validate_psswd(T, Acc, Policy)
    end.

validate_psswd_1(L) -> validate_psswd(L,0, fun(Mn,Mx, Letra,String) -> policy1(Mn,Mx, Letra,String) end).
validate_psswd_2(L) -> validate_psswd(L,0, fun(Pos1,Pos2, Letra,String) -> policy2(Pos1,Pos2, Letra,String) end).