% validate_main_menu_input(+Input) - validates Input
validate_main_menu_input(Input) :- number(Input), member(Input, [1,2,3,4, 5]), !.
validate_main_menu_input(_Input) :- write('Input is not valid!'),nl, fail, !.

% main_menu_input(-Input) - Gets input from user
main_menu_input(Option) :- 
        repeat,
        write('Choose an option: '),
        read(Option),
        validate_main_menu_input(Option).


% validate_before_game_input(+Input) - validates Input
validate_before_game_input(Input) :- atom(Input),member(Input, ['Color','Height']), !.
validate_before_game_input(_Input) :- write('Input is not valid!'), nl, fail,!.

% before_game_input(-Input) - Gets input from user
before_game_input(Option):-
        repeat,
        write('Player 1 choose what you want to play for(\'Color\' or \'Height\'): '),
        read(Option),
        validate_before_game_input(Option).

% validate_first_move_exception_input(+Input) - validates Input
validate_first_move_exception_input(C-R-H-Color) :-  
        atom(C), 
        number(R), 
        atom(H), 
        atom(Color), 
        member(C, ['a','b','c','d','e','f','g','h']), 
        member(R,[1,2,3,4,5,6,7,8]), 
        member(H,['b','m','s']), 
        member(Color, ['r','g','b']), !.
validate_first_move_exception_input(_Input) :- write('Input is not valid!'),nl,fail,!.


% first_move_exception_input(-Input,+Turn) - Gets input from user
first_move_exception_input(Col1-Row1-Height-Color,Turn) :- !,
        repeat,
        format('Player ~w choose where to place your tree and its height and color. (Example :. Place a Big Red Tree on a2 -> a-2-b-r): ', [Turn]),
        read(Col-Row-Height-Color),
        validate_first_move_exception_input(Col-Row-Height-Color),
        convert_column(Col,Col1),
        convert_row(Row,Row1).



% validate_move_moving_input_helper(+Input,ListOfValidMoves) - validates Input
validate_move_moving_input(Col1-Row1-Squares-Direction,VMM) :-
        number(Col1), number(Row1), number(Squares), atom(Direction),
        member(Row1, [1,2,3,4,5,6,7,8]),
        member(Col1, [1,2,3,4,5,6,7,8]),
        member(Squares, [1,2,3,4,5,6,7]),
        member(Direction, ['u','d','l','r']),
        validate_move_moving_input_helper(Col1-Row1-Squares-Direction,VMM).

validate_move_moving_input_helper(_Col1-_Row1-_Squares-_Direction, []) :- !, write('Invalid Input!'),nl,fail.
validate_move_moving_input_helper(Col1-Row1-Squares-Direction,[[Col1-Row1-Moves]|_T]) :- !, (member(Squares-Direction, Moves); write('Invalid Input!'),nl,fail).
validate_move_moving_input_helper(Col1-Row1-_Squares-_Direction,[[_Col2-_Row2-_Moves]|_T]) :- validate_move_moving_input_helper(Col1-Row1-_Squares-_Direction, _T).

% move_moving_input(-Input) - Gets input from user
move_moving_input(Col1-Row1-Squares-Direction, Turn,VMM) :- 
        repeat,
        format('Player ~w choose which piece you want to move, how many squares and in which direction (Example :. a7 6 squares to the left -> a-7-6-l): ',[Turn]),
        read(Col-Row-Squares-Direction),
        convert_column(Col,Col1),
        convert_row(Row,Row1),
        validate_move_moving_input(Col1-Row1-Squares-Direction, VMM).



% validate_move_placing_input(+Input,ListOfValidMoves) - validates Input
validate_move_placing_input(Height-Color,VPM) :- atom(Height),atom(Color), member(Height-Color,VPM), !.
validate_move_placing_input(_Input,_Vpm) :- write('Invalid Input'),nl, fail, !.

% move_placing_input(-Input) - Gets input from user
move_placing_input(Height-Color,Turn,VPM) :-
        repeat,
        format('Player ~w choose which tree you want to place: Example::(Big Red -> b-r; Medium Blue -> m-b; Small Green -> s-g)',[Turn]),
        read(Height-Color),
        validate_move_placing_input(Height-Color,VPM).

% validate_pc_lvl_input(+Input) - validates Input
validate_pc_lvl_input(Lvl) :- number(Lvl), member(Lvl,[1,2]), !.
validate_pc_lvl_input(_Lvl) :- write('Input is not valid!'), nl, fail,!.

% pc_lvl_input(-Input) - Gets input from user
pc_lvl_input(Pc, Lvl) :-
        repeat,
        format('Choose the level of Computer ~w: ', [Pc]),
        read(Lvl),
        validate_pc_lvl_input(Lvl).

% validate_pc_obj_input(+Input) - validates Input
validate_pc_obj_input(Obj) :- atom(Obj), member(Obj,['Color','Height']), !.
validate_pc_obj_input(_Obj) :- write('Input is not valid!'), nl, fail,!.


% pc_obj_input(-Input) - Gets input from user
pc_obj_input(Obj) :-
        repeat,
        format('What is Computer 1\'s Objective: ', []),
        read(Obj),
        validate_pc_obj_input(Obj).

% rules_input(+Input) - validates Input
validate_rules_input(Input) :- number(Input), member(Input, [1]),!.
validate_rules_input(_Input) :- write('Input is not valid!'), nl, fail,!.

% rules_input(-Input) - Gets input from user
rules_input :-
        repeat,
        format('Choose an option: ',[]),
        read(Input),
        validate_rules_input(Input).