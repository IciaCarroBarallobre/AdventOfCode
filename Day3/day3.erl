-module(day3).
-export([read/1, countTressSlopes/3]).

%%%%%%% READ AND PARSE THE INPUT 
read(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    string:tokens(erlang:binary_to_list(Binary), "\n").

%%%%%%
treeOrFree(String) -> 
    if 
        ("#" == String) -> 1; 
        true ->  0
    end.

calcularColumna(Right, Row, Total_Columns) ->  
    Number =  1+Right*Row,
    Resto = Total_Columns * erlang:floor(Number / Total_Columns),
    Result = Number - Resto,
    if 
        (Result == 0) -> Total_Columns;
        true -> Result
    end.

countTressSlopes(Right,Down,[_|T]) -> countTressSlopes(Right,Down, T, 1,1, 0) .
countTressSlopes(Right, Down, Forest, Row, Count, Acc) ->
case Forest of
    [H|T] -> 
        if 
            ((Count rem Down) == 0) -> 
                Item = lists:nth(calcularColumna(Right, Row, string:length(H)), H),
                countTressSlopes(Right,Down, T, Row+1, Count+1, Acc +treeOrFree([Item]));
            true -> countTressSlopes(Right,Down,T, Row, Count+1, Acc)
        end;
    [] -> Acc
end.


%%%%% SOLVE

%%%%%% Part 1
%% L = day3:read("input.txt").
%% day3:countTressSlopes(3,1,L). %% 289

%%%%%% Part 2
%% day3:countTressSlopes(5,1,L). %% 89
%% day3:countTressSlopes(7,1,L). %% 71
%% day3:countTressSlopes(1,1,L). %% 84
%% day3:countTressSlopes(1,2,L). %% 36

%%%%%% Examples
%% Example = day3:read("example.txt").
%% day3:countTressSlopes(1,1,Example). %%2
%% day3:countTressSlopes(3,1,Example). %%7
%% day3:countTressSlopes(5,1,Example). %%3
%% day3:countTressSlopes(7,1,Example). %%4 (Tiene fallo)
%% day3:countTressSlopes(1,2,Example). %%2
