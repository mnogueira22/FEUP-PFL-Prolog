% The initial state of the game
initial_state([[n-a,n-a,n-a,n-a,n-a,n-a,n-a,n-a],
               [n-a,n-a,n-a,n-a,n-a,n-a,n-a,n-a],
               [n-a,n-a,n-a,n-a,n-a,n-a,n-a,n-a],
               [n-a,n-a,n-a,n-a,n-a,n-a,n-a,n-a],
               [n-a,n-a,n-a,n-a,n-a,n-a,n-a,n-a],
               [n-a,n-a,n-a,n-a,n-a,n-a,n-a,n-a],
               [n-a,n-a,n-a,n-a,n-a,n-a,n-a,n-a],
               [n-a,n-a,n-a,n-a,n-a,n-a,n-a,n-a]]).

% A test state of the end of the game  
test_state([
    [b-g, b-r, b-b, b-r, b-g, b-b, b-g, b-r],
    [m-r, m-g, m-b, m-g, m-r, m-b, m-r, m-g],
    [n-a, s-r, n-a, s-b, s-r, n-a, s-g, s-b],
    [b-g, b-b, b-r, b-r, b-g, b-b, b-g, b-r],
    [m-g, m-r, m-b, m-g, m-r, m-b, m-r, m-g],
    [s-r, s-g, s-b, s-r, s-g, s-b, s-r, n-a],
    [b-b, b-g, b-g, b-r, n-a, b-r, b-g, n-a],
    [m-b, m-r, n-a, m-g, m-r, m-g, m-r, m-b]
]).



% switch_turn(CurrentPlayer, NewPlayer) - switches the turn between players.
switch_turn(1,2).
switch_turn(2,1).

% create_player(-Player) - creates a player at the beginning of the game.
create_player([3,3,3,3,3,3,3,3,3]) :- !.

% get_all_coords(-List) - creates a list with all the possible coordinates on a 8x8 board
get_all_coords([1-1,2-1,3-1,4-1,5-1,6-1,7-1,8-1,1-2,2-2,3-2,4-2,5-2,6-2,7-2,8-2,1-3,2-3,3-3,4-3,5-3,6-3,7-3,8-3,1-4,2-4,3-4,4-4,5-4,6-4,7-4,8-4,1-5,2-5,3-5,4-5,5-5,6-5,7-5,8-5,1-6,2-6,3-6,4-6,5-6,6-6,7-6,8-6,1-7,2-7,3-7,4-7,5-7,6-7,7-7,8-7,1-8,2-8,3-8,4-8,5-8,6-8,7-8,8-8]) :- !.

% convert_row(?Row,?NewRow) - converts a row from the input. Because of the way the board is displayed to the user. For instance, for the user row 1 represents the last row however it is easier for the last row to be 8. Can also be used the other way around.
convert_row(1,8).
convert_row(2,7).
convert_row(3,6).
convert_row(4,5).
convert_row(5,4).
convert_row(6,3).
convert_row(7,2).
convert_row(8,1).

% convert_column(?Col, ?NewCol) - converts a col from the input. Because the user writes the column with a letter it needs to be converted to a number for easier usability. Can also be used the other way around.
convert_column('a', 1).
convert_column('b', 2).
convert_column('c', 3).
convert_column('d', 4).
convert_column('e', 5).
convert_column('f', 6).
convert_column('g', 7).
convert_column('h', 8).

% convert_tree_type(?NewType,?Type) - converts tree types to numbers or numbers to tree types.
convert_tree_type(1, b-r).
convert_tree_type(2, m-r).
convert_tree_type(3, s-r).
convert_tree_type(4, b-g).
convert_tree_type(5, m-g).
convert_tree_type(6, s-g).
convert_tree_type(7, b-b).
convert_tree_type(8, m-b).
convert_tree_type(9, s-b).

% convert_tree_type_name(+TreeType, -FullName ) - convert the symbols to the full name of the tree.
convert_tree_type_name(b-r, 'Big Red Tree').
convert_tree_type_name(m-r, 'Medium Red Tree').
convert_tree_type_name(s-r, 'Small Red Tree').
convert_tree_type_name(b-g, 'Big Green Tree').
convert_tree_type_name(m-g, 'Medium Green Tree').
convert_tree_type_name(s-g, 'Small Green Tree').
convert_tree_type_name(b-b, 'Big Blue Tree').
convert_tree_type_name(m-b, 'Medium Blue Tree').
convert_tree_type_name(s-b, 'Small Blue Tree').

% update_player(+Player, +TreeType, -NewPlayer) - updates the player after a placing move considering which type of tree They used.
update_player([BR,MR,SR,BG,MG,SG,BB,MB,SB],b-r,[BR1,MR,SR,BG,MG,SG,BB,MB,SB]) :- !,BR1 is BR - 1.
update_player([BR,MR,SR,BG,MG,SG,BB,MB,SB],m-r,[BR,MR1,SR,BG,MG,SG,BB,MB,SB]) :- !,MR1 is MR - 1.
update_player([BR,MR,SR,BG,MG,SG,BB,MB,SB],s-r,[BR,MR,SR1,BG,MG,SG,BB,MB,SB]) :- !,SR1 is SR - 1.
update_player([BR,MR,SR,BG,MG,SG,BB,MB,SB],b-g,[BR,MR,SR,BG1,MG,SG,BB,MB,SB]) :- !,BG1 is BG - 1.
update_player([BR,MR,SR,BG,MG,SG,BB,MB,SB],m-g,[BR,MR,SR,BG,MG1,SG,BB,MB,SB]) :- !,MG1 is MG - 1.
update_player([BR,MR,SR,BG,MG,SG,BB,MB,SB],s-g,[BR,MR,SR,BG,MG,SG1,BB,MB,SB]) :- !,SG1 is SG - 1.
update_player([BR,MR,SR,BG,MG,SG,BB,MB,SB],b-b,[BR,MR,SR,BG,MG,SG,BB1,MB,SB]) :- !,BB1 is BB - 1.
update_player([BR,MR,SR,BG,MG,SG,BB,MB,SB],m-b,[BR,MR,SR,BG,MG,SG,BB,MB1,SB]) :- !,MB1 is MB - 1.
update_player([BR,MR,SR,BG,MG,SG,BB,MB,SB],s-b,[BR,MR,SR,BG,MG,SG,BB,MB,SB1]) :- !,SB1 is SB - 1.

% calculate_new_coords(+Col-Row-Squares-Direction, -Col-Row) - calculates the new coordinates for moving a tree.
calculate_new_coords(Col-Row-Squares-d, Col-Row1) :- Row1 is Row + Squares.
calculate_new_coords(Col-Row-Squares-r, Col1-Row) :- Col1 is Col + Squares.
calculate_new_coords(Col-Row-Squares-l, Col1-Row) :- Col1 is Col - Squares.
calculate_new_coords(Col-Row-Squares-u, Col-Row1) :- Row1 is Row - Squares.

% eliminate_from_board(+GameState, +Col-Row, -Height-Color, -NewGameState) - eliminates a tree from the board.
/*
    GameState -> The current GameState
    Col-Row -> The location of the piece to be eliminated
    Height-Color -> The type of tree that was eliminated
    NewGameState -> The new GameState after eliminating a tree
*/
eliminate_from_board([H|_T],_Col,1,_Height-_Color,[H1|_T]) :- !,eliminate_from_board_helper(H,_Col,_Height-_Color,H1).
eliminate_from_board([_H|_T],_Col,Row, _Height-_Color, [_H|_T1]):-
   Row1 is Row - 1,
    eliminate_from_board(_T, _Col, Row1, _Height-_Color, _T1).

% eliminate_from_board_helper(+Row, +Col, -Height-Color, -NewRow) - helper for eliminate_from_board/4, eliminates an element from a row.
/*
    Row -> The Row that contains the tree
    Col -> The Col where the tree is
    Height-Color -> The type of tree that was eliminated
    NewRow -> The new NewRow after eliminating a tree
*/
eliminate_from_board_helper([Height-Color|T], 1, Height-Color, [n-a|T]) :- !.
eliminate_from_board_helper([_H|_T],Col, _Height-_Color, [_H|_T1]) :-
    Col1 is Col - 1,
    eliminate_from_board_helper(_T,Col1, _Height-_Color, _T1).

% update_board_place(+GameState, +Col-Row-Height-Color, -NewGameState) - updates the board with a new move.
/*
    GameState -> The current GameState
    Col-Row-Height-Color -> The coordinates of the move and the type of tree.
    NewGameState -> The new GameState after the move
*/
update_board_place([H | T], Col-1-Height-Color, [H1 | T]) :- 
    update_board_place_helper(H, Col-Height-Color, H1).
update_board_place([H | T], Col-Row-Height-Color, [H | T1]) :-
    Row1 is Row - 1,
    update_board_place(T, Col-Row1-Height-Color, T1).

% update_board_place_helper(+Row, +Col-Row-Height-Color, -NewRow) - helper to update_board_place. Places an element in a row.
/*
    Row -> The Current Row
    Col-Height-Color -> The coordinates of the move and the type of tree.
    NewRow -> The new Row after the move

*/
update_board_place_helper([n-a | T], 1-Height-Color, [Height-Color | T]) :- !.
update_board_place_helper([H | T], Col-Height-Color, [H | T1]) :-
    Col1 is Col - 1,
    update_board_place_helper(T, Col1-Height-Color, T1).

% update_board_move(+GameState, +Col-Row-Squares-Direction, -NewGameState) - Moves a piece on the board
/*
    GameState -> Current GameState
    Col-Row-Squares-Direction -> The coordinates of the piece to be moved. Squares and Direction to move the piece.
    NewGameState -> The new GameState
*/
update_board_move(GameState, Col-Row-Squares-Direction, NewGameState) :- calculate_new_coords(Col-Row-Squares-Direction, FCol-FRow), 
    eliminate_from_board(GameState,Col,Row,Height-Color,NewGameState1), 
    update_board_place(NewGameState1,FCol-FRow-Height-Color, NewGameState).

% track_pieces(+Col,+Row,+Pieces, -NewPieces) - adds a piece to the pieces list
track_pieces(Col1,Row1, Pieces, NewPieces) :- append(Pieces,[Col1-Row1],NewPieces).

track_pieces(Col1,Row1, [Col1-Row1|_T], [Col2-Row2|_T], Squares-Direction) :-!,nl,calculate_new_coords(Col1-Row1-Squares-Direction, Col2-Row2),nl.
track_pieces(_Col1,_Row1, [_H|_T], [_H|_T1], _Squares-_Direction) :- track_pieces(_Col1,_Row1,_T,_T1,_Squares-_Direction).

% select_row(+RowNumber, +GameState, -Row) - Selects a particular Row from the Grid
select_row(1, [H|_], H) :- !.
select_row(RowN, [_|T], Row) :- !,
    RowN1 is RowN - 1,
    select_row(RowN1, T, Row).
select_row(_, [], _) :- fail.

% select_col(+ColN,+GameState, -Col) - Selects a particular column from the Grid
select_col(_Col, [], []) :- !.
select_col(Col, [H|_T], [NewElem|_T1]) :- nth1(Col,H,NewElem), select_col(Col, _T, _T1).

% remove_f(+List, -List) - remove the letter f from the list.
remove_f([],[]) :- !.
remove_f([f],[]) :- !.
remove_f([f|_T], []) :- !.
remove_f([H|_T], [H|_T1]) :- remove_f(_T,_T1).

% find_horizontal_left_moves(+Col,+Row,-LM) - generates all possible moves to the left for a certain piece.
find_horizontal_left_moves(Col, Row, LM) :- find_horizontal_left_moves_helper(Col,Row,LM1), reverse(LM1,LM2), remove_f(LM2,LM).

find_horizontal_left_moves_helper(_Col, [], []) :- !.
find_horizontal_left_moves_helper(1, _Row, []) :- !.
find_horizontal_left_moves_helper(Col, [n-a|_T], [Col1-l|_T1]) :- !,Col1 is Col - 1, find_horizontal_left_moves_helper(Col1, _T, _T1).
find_horizontal_left_moves_helper(Col, [_H|_T], [f|_T1]) :- Col1 is Col - 1, find_horizontal_left_moves_helper(Col1, _T, _T1).

% find_vertical_up_moves(+Col,+Row,-LM) - generates all possible moves upwards for a certain piece.
find_vertical_up_moves(Col, Row, LM) :- find_vertical_up_moves_helper(Col,Row,LM1), reverse(LM1,LM2), remove_f(LM2,LM).

find_vertical_up_moves_helper(_Col, [], []) :- !.
find_vertical_up_moves_helper(1, _Row, []) :- !.
find_vertical_up_moves_helper(Col, [n-a|_T], [Col1-u|_T1]) :- !,Col1 is Col - 1, find_vertical_up_moves_helper(Col1, _T, _T1).
find_vertical_up_moves_helper(Col, [_H|_T], [f|_T1]) :- Col1 is Col - 1, find_vertical_up_moves_helper(Col1, _T, _T1).

% select_row_right_part(+Col, +Row, -RowRightPart) - selects the part of the row after the column.
select_row_right_part(1, [_H|T], T) :- !.
select_row_right_part(Col,[_H|_T], _Row) :- Col1 is Col - 1, select_row_right_part(Col1, _T, _Row).

% find_horizontal_right_moves(+Col,+Row,-LM) - generates all possible moves to the right for a certain piece.
find_horizontal_right_moves(_Col, [], []) :- !.
find_horizontal_right_moves(Col, [n-a|_T], [Col-r|_T1]) :- !,Col1 is Col + 1, find_horizontal_right_moves(Col1,_T,_T1).
find_horizontal_right_moves(_Col,[H|_T], []) :- H \= n-a.

% find_vertical_up_moves(+Col,+Row,-LM) - generates all possible moves downwards for a certain piece.
find_vertical_down_moves(_Col, [], []) :- !.
find_vertical_down_moves(Col, [n-a|_T], [Col-d|_T1]) :- !,Col1 is Col + 1, find_vertical_down_moves(Col1,_T,_T1).
find_vertical_down_moves(_Col,[H|_T], []) :- H \= n-a.

% find_horizontal_moves(+Row,+Col, -Moves) - generates all possible for horizontal moves for a certain piece
find_horizontal_moves(Row,Col,Moves) :- 
    select_row_right_part(Col,Row,Row1),
    find_horizontal_right_moves(1,Row1,MovesR),
    find_horizontal_left_moves(Col,Row,MovesL),
    append(MovesL,MovesR,Moves).

% find_vertical_moves(+Row,+Col, -Moves) - generates all possible for vertical moves for a certain piece
find_vertical_moves(Row,Col, Moves) :-
    select_row_right_part(Row,Col,Col1),
    find_vertical_down_moves(1,Col1,MovesD),
    find_vertical_up_moves(Row,Col,MovesU),
    append(MovesU,MovesD,Moves).

% find_moves(+GameState,+Row,+Col,-Moves) - generates all possible moves for a certain piece
find_moves(GameState,Row,Col,Moves) :-
    select_row(Row,GameState,NewRow),
    select_col(Col,GameState,NewCol),
    find_vertical_moves(Row,NewCol,MovesV),
    find_horizontal_moves(NewRow,Col,MovesH),
    append(MovesH,MovesV,Moves).

% valid_moving_moves_for_each_piece(+GameState, +Col-Row, -VMM) - generates all possible moving moves for all pieces on the board.
valid_moving_moves_for_each_piece(_GameState, Col-Row, VMM) :-
    findall(Col-Row-Moves, find_moves(_GameState,Row,Col,Moves), VMM).

valid_moving_moves_helper(GameState, Positions, VMM) :-
    valid_moving_moves_recursive(GameState, Positions, [], VMM).

valid_moving_moves_recursive(_, [], VMM, VMM).
valid_moving_moves_recursive(GameState, [Col-Row|T], Acc, VMM) :-
    valid_moving_moves_for_each_piece(GameState, Col-Row, VP),
    valid_moving_moves_recursive(GameState, T, [VP|Acc], VMM).

% valid_placing_moves_helper(+Player, -VPM) - generates all possible placing moves for a player.
valid_placing_moves_helper(Player, VPM) :-
    valid_placing_moves_helper_helper(Player, 1, [], VPM).

valid_placing_moves_helper_helper([], _, Acc, Acc) :- !.
valid_placing_moves_helper_helper([0| T], Counter, Acc, VPM) :- !,
    Counter1 is Counter + 1,
    valid_placing_moves_helper_helper(T, Counter1, Acc, VPM).
valid_placing_moves_helper_helper([_H | T], Counter, Acc, VPM) :-
    Counter1 is Counter + 1,
    convert_tree_type(Counter, TreeType),
    valid_placing_moves_helper_helper(T, Counter1, [TreeType | Acc], VPM).

% inbouds(+Col,+Row) - Checks if the coordinates are inside the board.
in_bounds(Col,Row) :-
    Row > 0, Row < 9, Col > 0, Col < 9.

% select_cell(+GameState,+Col,+Row,-Height-Color) - Checks which tree type is in the specified cell.
select_cell(GameState,Col,Row,Height-Color) :-
    select_row(Row, GameState, Row1),
    nth1(Col,Row1, Height-Color).

% adjacent_cell(+Col, +Row, -Col, -Row1) - generates the neighbours for a cell.
adjacent_cell(Col, Row, Col1, Row1) :-
    Col1 is Col - 1, Row1 is Row - 1;
    Col1 is Col, Row1 is Row - 1;
    Col1 is Col + 1, Row1 is Row - 1;
    Col1 is Col - 1, Row1 is Row;
    Col1 is Col + 1, Row1 is Row;
    Col1 is Col - 1, Row1 is Row + 1;
    Col1 is Col, Row1 is Row + 1;
    Col1 is Col + 1, Row1 is Row + 1.

% bfs_helper(+GameState, -LC, -LH) :- Given a GameState find the biggest clusters of each color and height and groups them in two lists.
bfs_helper(GameState,[SK1-Color1, SK2-Color2, SK3-Color3],[SK4-Height1, SK5-Height2, SK6-Height3]) :- 
    get_all_coords(List), 
    loop_board_color(GameState,List,LC1), sort(LC1,SLC1), reverse(SLC1,RLC1), find_biggest(RLC1,r,SK1-Color1), find_biggest(RLC1,g,SK2-Color2), find_biggest(RLC1,b,SK3-Color3),
    loop_board_height(GameState,List,LH1), sort(LH1,SLH1), reverse(SLH1,RLH1), find_biggest(RLH1,b,SK4-Height1), find_biggest(RLH1,m,SK5-Height2), find_biggest(RLH1,s,SK6-Height3).

% find_biggest(+List,+Target,-Max-Target) - Finds the biggest number associated with target. If it doesnt find any then assigns it 0 as default.
find_biggest([],Target,0-Target) :- !.
find_biggest([SK-Target|_T],Target,SK-Target) :- !.
find_biggest([_SK-_HC|_T], Target, _L) :- find_biggest(_T,Target,_L).

% loop_board_height(+GameState,+ListCoords,-List) - Finds all the clusters for the height objective.
loop_board_height(_GameState, [], []).
loop_board_height(GameState,[Col-Row|_T],[SK-Height|_T1]) :- select_cell(GameState,Col,Row, Height-_Color), explore_height([Col-Row], GameState, Height, [], 0,SK), loop_board_height(GameState, _T, _T1).

% explore_height(+[Origin], +GameState, +Target, -Visited, +Size, -SK) - explored the board using bfs to count clusters for the height objective.
explore_height([],_GameState, _Target,_Visited,Size,Size) :- !.
explore_height([Col-Row|T], GameState, Target, Visited,Size,SK) :-
    findall(Col1-Row1, (adjacent_cell(Col, Row, Col1, Row1), in_bounds(Col1, Row1), \+(member(Col1-Row1,Visited)),\+ (member(Col1-Row1,T)), select_cell(GameState,Col1,Row1,Target-_Color)), Neighbours),
    append(T,Neighbours,NR),
    Size1 is Size + 1,
    explore_height(NR,GameState,Target, [Col-Row|Visited], Size1,SK).

% loop_board_height(+GameState,+ListCoords,-List) - Finds all the clusters for the color objective.
loop_board_color(_GameState, [], []).
loop_board_color(GameState,[Col-Row|_T],[SK-Color|_T1]) :- select_cell(GameState,Col,Row, _Height-Color), explore_color([Col-Row], GameState, Color, [], 0,SK), loop_board_color(GameState, _T, _T1).

% explore_color(+[Origin], +GameState, +Target, -Visited, +Size, -SK) - explored the board using bfs to count clusters for the color objective.
explore_color([],_GameState, _Target,_Visited,Size,Size) :- !.
explore_color([Col-Row|T], GameState, Target, Visited,Size,SK) :-
    findall(Col1-Row1, (adjacent_cell(Col, Row, Col1, Row1), in_bounds(Col1, Row1), \+(member(Col1-Row1,Visited)),\+ (member(Col1-Row1,T)), select_cell(GameState,Col1,Row1,_Height-Target)), Neighbours),
    append(T,Neighbours,NR),
    Size1 is Size + 1,
    explore_color(NR,GameState,Target, [Col-Row|Visited], Size1,SK).


% get_sum(+List,-Sum) - gets the sum of elements in a list
get_sum([],0).
get_sum([SK-_S|_T], Total) :- get_sum(_T,Total1), Total is Total1 + SK.  


% get_winner(+Objective,+H,+C,-Winner) - gets the winner of the game
get_winner('Color',H,C,1) :- C > H , !.
get_winner('Color',H,C,2) :- H > C , !.
get_winner('Height',H,C,2) :- C > H , !.
get_winner('Height',H,C,1) :- H > C , !.


% string_lenght_red(+Digits, -StringSize) - used to calculate the number of spaces to use in some drawing functions.
string_length_red(X,S) :- S > 9, X is 7 + 2; X is 7 + 1.
string_length_blue(X,S) :- S > 9, X is 8 + 2; X is 8 + 1.
string_length_green(X,S) :- S > 9, X is 9 + 2; X is 9 + 1.
string_length_medium(X,S) :- S > 9, X is 10 + 2; X is 10 + 1.


% select_random_tree(+VPM,-Height-Color) - used to select a random tree to use in computer moves.
select_random_tree(VPM,Height-Color) :-
    length(VPM,VPMS), LVPM is VPMS + 1,
    random(1,LVPM,Ele),
    nth1(Ele,VPM,Height-Color).

% select_random_grind_slot(-Col-Row) - used to select a random grid slot to use in computer moves.
select_random_grid_slot(Col-Row) :-
    get_all_coords(CoordsList),
    length(CoordsList,Size), LCL is Size + 1,
    random(1,LCL,Ele),
    nth1(Ele,CoordsList,Col-Row).


% check_piece_has_valid_moves_helper(+GameState,+Pieces,+Col-Row) - checks wheter a piece as valid moves
check_piece_has_valid_moves(GameState,Pieces,Col-Row):-
    valid_moving_moves(GameState,Pieces,VMM),
    check_piece_has_valid_moves_helper(Col-Row,VMM).

check_piece_has_valid_moves_helper(_Col-_Row, []) :- fail, !.
check_piece_has_valid_moves_helper(Col-Row, [[Col-Row-Moves]|_T]) :- length(Moves,X), X < 1,fail,!.
check_piece_has_valid_moves_helper(Col-Row, [[Col-Row-_Moves]|_T]) :- !.
check_piece_has_valid_moves_helper(Col-Row, [[_Col1-_Row1-_Moves]|_T]) :- check_piece_has_valid_moves_helper(Col-Row,_T).

% select_random_piece_to_move(+GameState,+Pieces,-Col-Row) - used to select a piece to move to use in computer moves.
select_random_piece_to_move(GameState,Pieces,Col-Row) :-
    repeat,
    length(Pieces,X), X1 is X + 1,
    random(1,X1,Ele),
    nth1(Ele,Pieces,Col-Row),
    check_piece_has_valid_moves(GameState,Pieces,Col-Row).

% select_random_available_move(+Col-Row, +VMM, -Move) - used to select move to use in computer moves.
select_random_available_move(_Col-_Row, [], _Move) :- !.
select_random_available_move(Col-Row, [[Col-Row-Moves]|_T],Move) :- !,
    length(Moves,X), X1 is X + 1,
    random(1,X1,Ele),
    nth1(Ele,Moves,Move).
select_random_available_move(Col-Row,[[_Col1-_Row1-_Moves]|_T],_Move) :- select_random_available_move(Col-Row,_T,_Move).

% value_helper(+GameState, -Value) - used to select move to use in computer moves.
value_helper(GameState,Value) :-
    bfs_helper(GameState,LC,LH),
    get_sum(LC,C),
    get_sum(LH,H),
    Value is C-H.

% get_all_moves(+GameState, +Bot, +Pieces, -AM) - Puts all valid moving moves and all valid placing moves in a list together.
get_all_moves(GameState, Bot, Pieces, AM) :-
    valid_moving_moves(GameState, Pieces, VMM),
    valid_placing_moves(Bot, VPM),
    get_all_moves_helper(VMM, VPM, AM).

get_all_moves_helper([], _, []).
get_all_moves_helper([[Col-Row-Moves]|T], VPM, AM) :-
    get_all_moves_helper_helper(Col-Row-Moves, VPM, NAM),
    get_all_moves_helper(T, VPM, AM1),
    append(NAM, AM1, AM).

get_all_moves_helper_helper(_Col-_Row-_Moves, [], []) :- !.
get_all_moves_helper_helper(Col-Row-Moves, [H1|T1], AM) :-
    get_all_moves_helper_helper_helper(Col-Row-Moves, H1, NAM),
    get_all_moves_helper_helper(Col-Row-Moves, T1, AM1),
    append(NAM, AM1, AM).

get_all_moves_helper_helper_helper(_Col-_Row-[], _Height-_Color, []).
get_all_moves_helper_helper_helper(Col-Row-[Squares-Direction|T], Height-Color, [Col-Row-Squares-Direction-Height-Color|T1]) :-
    get_all_moves_helper_helper_helper(Col-Row-T, Height-Color, T1).


% evaluate_all_moves(+GameState, +Moves, -ListOfMoves) - Evaluates all the moves in a particular gamestate and puts the in a list.
evaluate_all_moves(_GameState, [], []) :- !.
evaluate_all_moves(GameState, [Col-Row-Squares-Direction-Height-Color|T], [Value-Col-Row-Squares-Direction-Height-Color|T1]) :-
    update_board_move(GameState, Col-Row-Squares-Direction, NewGameState),
    update_board_place(NewGameState, Col-Row-Height-Color, NewestGameState),
    value(NewestGameState, Value),
    evaluate_all_moves(GameState, T, T1).


% get_highest_move(+Objective, +Moves, +CurrHighest, +CurrBestMove, -BestMove) - Gets the best move from a list.
get_highest_move('Color',[], _BestValue, CurrentBestMove, CurrentBestMove) :- !.

get_highest_move('Color',[Value1-Col1-Row1-Squares1-Direction1-Height1-Color1 | T], CurrentBestValue, _CurrentBestMove, Move) :-
    Value1 > CurrentBestValue, !,
    get_highest_move('Color',T, Value1, Value1-Col1-Row1-Squares1-Direction1-Height1-Color1, Move).

get_highest_move('Color',[_Value1-_Col1-_Row1-_Squares1-_Direction1-_Height1-_Color1 | T], CurrentBestValue, CurrentBestMove, Move) :-
    get_highest_move('Color',T, CurrentBestValue, CurrentBestMove, Move).

get_highest_move('Height',[], _BestValue, CurrentBestMove, CurrentBestMove) :- !.

get_highest_move('Height',[Value1-Col1-Row1-Squares1-Direction1-Height1-Color1 | T], CurrentBestValue, _CurrentBestMove, Move) :-
    Value1 < CurrentBestValue, !,
    get_highest_move('Height',T, Value1, Value1-Col1-Row1-Squares1-Direction1-Height1-Color1, Move).

get_highest_move('Height',[_Value1-_Col1-_Row1-_Squares1-_Direction1-_Height1-_Color1 | T], CurrentBestValue, CurrentBestMove, Move) :-
    get_highest_move('Height',T, CurrentBestValue, CurrentBestMove, Move).


% seletc_best_move(+GameState,-Col-Row,-Squares-Driection,-Height-Color,+Pieces,+Bot,+Objective) - select the best move for the computer to play
select_best_move(GameState,Col-Row,Squares-Direction,Height-Color,Pieces,Bot,Objective) :-
    get_all_moves(GameState,Bot,Pieces,AM),
    evaluate_all_moves(GameState,AM,[Value1-Col1-Row1-Squares1-Direction1-Height1-Color1|T]),
    get_highest_move(Objective,[Value1-Col1-Row1-Squares1-Direction1-Height1-Color1|T], Value1, Value1-Col1-Row1-Squares1-Direction1-Height1-Color1,_Value-Col-Row-Squares-Direction-Height-Color).