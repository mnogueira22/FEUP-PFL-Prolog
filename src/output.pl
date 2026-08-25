% draw_n(+N,+S) - draw S, N times
draw_n(0,_) :- !.
draw_n(N,S) :- N1 is N - 1, draw_n(N1,S), write(S).

% draw_code_n(+N,+C) - draw code C, N Times
draw_code_n(0,_) :- !.
draw_code_n(N,C) :- N1 is N - 1, draw_code_n(N1,C), put_code(C).

% draw_top_horizontal_line(+Size,+LeftMargin) - draws the top horizontal line
draw_top_horizontal_line(Size,LeftMargin) :-
    draw_n(LeftMargin,' '), put_code(0x2554),  draw_code_n(Size,0x2550), put_code(0x2557), nl.

% draw_bottom_horizontal_line(+Size,+LeftMargin) - draws the bottom horizontal line
draw_bottom_horizontal_line(Size,LeftMargin) :-
    draw_n(LeftMargin,' '), put_code(0x255A),  draw_code_n(Size,0x2550), put_code(0x255D), nl.

% draw_empty_lines(+N,+Size,+LeftMargin) - draws N empty lines
draw_empty_lines(0,_Size,_LeftMargin) :- !.
draw_empty_lines(N,Size,LeftMargin) :- 
    draw_n(LeftMargin,' '), put_code(0x2551), draw_n(Size,' '), put_code(0x2551), nl, 
    N1 is N - 1,
    draw_empty_lines(N1,Size,LeftMargin).

% draw_title(+Title,+LeftMargin,+LeftPadding) - draws the title
draw_title(Title, LeftMargin, LeftPadding) :-
    draw_n(LeftMargin,' '), put_code(0x2551), draw_n(LeftPadding,' '), write(Title), draw_n(LeftPadding,' '), put_code(0x2551), nl.

% draw_title(+Title,+LeftMargin,+LeftPadding,+RightPadding) - draws the subtitles
draw_subtitle(Subtitle, LeftMargin, LeftPadding,RightPadding) :-
draw_n(LeftMargin,' '), put_code(0x2551), draw_n(LeftPadding,' '), format('-- ~w',[Subtitle]), draw_n(RightPadding,' '), put_code(0x2551), nl.  

% draw_rule(+Test,+X,+Y) - draws a rule
draw_rule(Text, X, Y) :-
    draw_text(Text, X, Y).

% draw_main_menu - draws the main meu
draw_main_menu :-
    draw_top_horizontal_line(63,50),
    draw_empty_lines(2,63,50),
    draw_title('WALDMEISTER', 50,26),
    draw_empty_lines(2,63,50),
    draw_subtitle('PLAY HUMAN Vs HUMAN (Type: 1)',50,13,18),
    draw_subtitle('PLAY HUMAN Vs COMPUTER (Type: 2)',50,13,15),
    draw_subtitle('PLAY COMPUTER Vs COMPUTER (Type: 3)',50,13,12),
    draw_subtitle('RULES (Type: 4)',50,13,32),
    draw_subtitle('EXIT (Type: 5)',50,13,33),
    draw_empty_lines(2,63,50),
    draw_bottom_horizontal_line(63,50).

% draw_game_pieces_lines(+Row,+LeftMargin,+RowN) - draws the pieces on the board
draw_game_pieces_lines(Row,LeftMargin,RowNumber) :-
    LeftMargin1 is LeftMargin - 3,
    draw_n(LeftMargin1,' '), write(RowNumber),
    draw_n(2,' '), put_code(0x2551), draw_game_pieces_lines_helper(Row), nl.

draw_game_pieces_lines_helper([]) :- !.
draw_game_pieces_lines_helper([n-a|T]) :- !,
    draw_n(3, ' '), write(' '), draw_n(3, ' '), put_code(0x2551),
    draw_game_pieces_lines_helper(T).
draw_game_pieces_lines_helper([Piece|T]) :-
    draw_n(2, ' '),write(Piece), draw_n(2, ' '), put_code(0x2551),
    draw_game_pieces_lines_helper(T).

% draw_grid_bottom_line(+LeftMargin) - draws the grid bottom line
draw_grid_bottom_line(LeftMargin) :-
    draw_n(LeftMargin,' '), put_code(0x2551), draw_grid_bottom_line_helper(8), nl.

draw_grid_bottom_line_helper(0) :- !.
draw_grid_bottom_line_helper(N) :-
    N1 is N - 1, draw_code_n(7,0x2550), put_code(0x2551), draw_grid_bottom_line_helper(N1).

% draw_grid(+ListOfLists, +Rown) - draw the grid
draw_grid([H], RowNumber) :- !,
    draw_game_pieces_lines(H,50,RowNumber).
draw_grid([H|T],RowNumber) :- 
    draw_game_pieces_lines(H,50,RowNumber),
    RowNumber1 is RowNumber - 1,
    draw_grid_bottom_line(50),
    draw_grid(T,RowNumber1).

%draw_grid_bottom_notation(+LeftMargin) - draws the coordinates on the bottom of the grid
draw_grid_bottom_notation(LeftMargin) :-
    draw_n(LeftMargin,' '),
    draw_n(4, ' '), write('A'), draw_n(3, ' '),
    draw_n(4, ' '), write('B'), draw_n(3, ' '),
    draw_n(4, ' '), write('C'), draw_n(3, ' '),
    draw_n(4, ' '), write('D'), draw_n(3, ' '),
    draw_n(4, ' '), write('E'), draw_n(3, ' '),
    draw_n(4, ' '), write('F'), draw_n(3, ' '),
    draw_n(4, ' '), write('G'), draw_n(3, ' '),
    draw_n(4, ' '), write('H'), draw_n(3, ' '),nl.

% draw_right_margin(+Counter) - draws a right margin on specific cases
draw_right_margin(1) :- !,draw_n(6, ' ').
draw_right_margin(4) :- !.
draw_right_margin(7) :- !,draw_n(3, ' ').

%draw_player(+Player,+LeftMargin,?Counter) - Draws the trees the player has before his turn
draw_player([], _LeftMargin, _Counter) :- !.
draw_player([H1,H2,H3|T],LeftMargin, Counter) :-
    Counter1 is Counter + 1,
    Counter2 is Counter + 2,
    Counter3 is Counter + 3,
    convert_tree_type(Counter,CounterTT),convert_tree_type(Counter1,Counter1TT),convert_tree_type(Counter2,Counter2TT),
    convert_tree_type_name(CounterTT,Tree),convert_tree_type_name(Counter1TT,Tree1),convert_tree_type_name(Counter2TT,Tree2),
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(2, ' '), format('~w : ~w ~w : ~w ~w : ~w',[Tree,H1,Tree1,H2,Tree2,H3]), draw_right_margin(Counter), put_code(0x2551),nl,
    draw_player(T,LeftMargin,Counter3).

% draw_announcement(+Turn,+Player) - announces whose turn it is
draw_announcement(Turn, Player) :-
    draw_top_horizontal_line(63,50),
   (Turn =:= 1 -> draw_subtitle('Player 1\'s Turn',50,23,22); draw_subtitle('Player 2\'s Turn',50,23,22)),
   draw_empty_lines(2,63,50),
   draw_player(Player,50,1),
   draw_bottom_horizontal_line(63,50).

% display_game(+State,+Turn,+Player) - Displays the board
display_game(State, Turn, Player) :-
    draw_announcement(Turn,Player),
    draw_top_horizontal_line(63,50),
    draw_grid(State,8),
    draw_bottom_horizontal_line(63,50),
    draw_grid_bottom_notation(50).

display_game(State) :-
    draw_top_horizontal_line(63,50),
    draw_grid(State,8),
    draw_bottom_horizontal_line(63,50),
    draw_grid_bottom_notation(50).

% draw_rules -> draws the rules
draw_rules :-
    draw_top_horizontal_line(63, 50),
    draw_empty_lines(2, 63, 50),
    draw_title('RULES', 50, 29),
    draw_empty_lines(2, 63, 50),
    draw_subtitle('Both players aim to form the largest clusters', 50, 2, 13),
    draw_subtitle('One player scores the largest cluster in each colour', 50, 2, 6),
    draw_subtitle('The other player scores the largest cluster in height', 50, 2, 5),
    draw_subtitle('Players can place and relocate pegs on the gameboard', 50, 2, 6),
    draw_subtitle('Cluster-> Adjacent pegs of the same colour or height', 50, 2, 6),
    draw_subtitle('Game ends when all pegs placed, players count clusters', 50, 2, 4),
    draw_empty_lines(2, 63, 50),
    draw_subtitle('Back to menu (Type :1)', 50, 2, 36),
    draw_empty_lines(2, 63, 50),
    draw_bottom_horizontal_line(63, 50).

% draw_winner(+Winner, +ListColor, +ListHeight,+Color,+Height,+Objective) - draws the winner and the clusters each player made
draw_winner(Winner,ListColor,ListHeight,Color,Height,Objective) :-
    draw_top_horizontal_line(63,50),
    draw_empty_lines(2, 63, 50),
    (Winner =:= 1 -> draw_title('Player 1 Wins',50,25); draw_title('Player 2 Wins',50,25)),
    draw_empty_lines(2, 63, 50),
    draw_winner_helper(50,ListColor,ListHeight,Color,Height,Objective),
    draw_bottom_horizontal_line(63,50).

draw_winner_helper(LeftMargin,[SK1-_Color1, SK2-_Color2, SK3-_Color3],[SK4-_Height1, SK5-_Height2, SK6-_Height3],C,H,'Color') :-
    SpaceSize is 28,
    RightPaddingSize is 25,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(2, ' '), format('Player 1\'s Objective -> Color',[]), draw_n(2,' '), format('Player 2\'s Objective -> Height',[]),put_code(0x2551), nl,
    draw_empty_lines(1,63,50),
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Red -> ~w', [SK1]), string_length_red(X,SK1), SpaceSize1 is SpaceSize - X,draw_n(SpaceSize1,' '), format('Big -> ~w', [SK4]), string_length_red(V,SK4), RightPaddingSize1 is RightPaddingSize - V,draw_n(RightPaddingSize1,' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Green -> ~w', [SK2]), string_length_green(Y,SK2), SpaceSize2 is SpaceSize - Y,draw_n(SpaceSize2,' '), format('Medium -> ~w', [SK5]), string_length_medium(M,SK5), RightPaddingSize2 is RightPaddingSize - M,draw_n(RightPaddingSize2,' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Blue -> ~w', [SK3]), string_length_blue(Z,SK3), SpaceSize3 is SpaceSize - Z,draw_n(SpaceSize3,' '), format('Small -> ~w', [SK6]), string_length_green(N,SK6), RightPaddingSize3 is RightPaddingSize - N, draw_n(RightPaddingSize3,' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), draw_n(10,'-'), draw_n(18,' '), draw_n(10,'-'), draw_n(15, ' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Total -> ~w', [C]), draw_n(17,' '), format('Total -> ~w', [H]), draw_n(14, ' '), put_code(0x2551), nl.


draw_winner_helper(LeftMargin,[SK1-_Color1, SK2-_Color2, SK3-_Color3],[SK4-_Height1, SK5-_Height2, SK6-_Height3],C,H,'Height') :-
    SpaceSize is 28,
    RightPaddingSize is 25,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(2, ' '), format('Player 1\'s Objective -> Height',[]), draw_n(2,' '), format('Player 2\'s Objective -> Color',[]),put_code(0x2551), nl,
    draw_empty_lines(1,63,50),
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Big -> ~w', [SK4]), string_length_red(X,SK4), SpaceSize1 is SpaceSize - X,draw_n(SpaceSize1,' '), format('Red -> ~w', [SK1]), string_length_red(V,SK1), RightPaddingSize1 is RightPaddingSize - V,draw_n(RightPaddingSize1,' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Medium -> ~w', [SK5]), string_length_medium(Y,SK5), SpaceSize2 is SpaceSize - Y,draw_n(SpaceSize2,' '), format('Green -> ~w', [SK2]), string_length_green(M,SK2), RightPaddingSize2 is RightPaddingSize - M,draw_n(RightPaddingSize2,' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Small -> ~w', [SK6]), string_length_green(Z,SK6), SpaceSize3 is SpaceSize - Z,draw_n(SpaceSize3,' '), format('Blue -> ~w', [SK3]), string_length_blue(N,SK3), RightPaddingSize3 is RightPaddingSize - N, draw_n(RightPaddingSize3,' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), draw_n(10,'-'), draw_n(18,' '), draw_n(10,'-'), draw_n(15, ' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Total -> ~w', [H]), draw_n(17,' '), format('Total -> ~w', [C]), draw_n(14, ' '), put_code(0x2551), nl.

% draw_draw(+Objective,+LC,+LH,+C,+H) - draws the draw in case of a draw
draw_draw(Objective,LC,LH,C,H) :-
    draw_top_horizontal_line(63,50),
    draw_empty_lines(2, 63, 50),
    draw_title('Draw!',50,29),
    draw_empty_lines(2, 63, 50),
    draw_draw_helper(50,LC,LH,C,H,Objective),
    draw_bottom_horizontal_line(63,50).

draw_draw_helper(LeftMargin,[SK1-_Color1, SK2-_Color2, SK3-_Color3],[SK4-_Height1, SK5-_Height2, SK6-_Height3],C,H,'Color') :-
    SpaceSize is 28,
    RightPaddingSize is 25,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(2, ' '), format('Player 1\'s Objective -> Color',[]), draw_n(2,' '), format('Player 2\'s Objective -> Height',[]),put_code(0x2551), nl,
    draw_empty_lines(1,63,50),
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Red -> ~w', [SK1]), string_length_red(X,SK1), SpaceSize1 is SpaceSize - X,draw_n(SpaceSize1,' '), format('Big -> ~w', [SK4]), string_length_red(V,SK4), RightPaddingSize1 is RightPaddingSize - V,draw_n(RightPaddingSize1,' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Green -> ~w', [SK2]), string_length_green(Y,SK2), SpaceSize2 is SpaceSize - Y,draw_n(SpaceSize2,' '), format('Medium -> ~w', [SK5]), string_length_medium(M,SK5), RightPaddingSize2 is RightPaddingSize - M,draw_n(RightPaddingSize2,' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Blue -> ~w', [SK3]), string_length_blue(Z,SK3), SpaceSize3 is SpaceSize - Z,draw_n(SpaceSize3,' '), format('Small -> ~w', [SK6]), string_length_green(N,SK6), RightPaddingSize3 is RightPaddingSize - N, draw_n(RightPaddingSize3,' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), draw_n(10,'-'), draw_n(18,' '), draw_n(10,'-'), draw_n(15, ' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Total -> ~w', [C]), draw_n(17,' '), format('Total -> ~w', [H]), draw_n(14, ' '), put_code(0x2551), nl.


draw_draw_helper(LeftMargin,[SK1-_Color1, SK2-_Color2, SK3-_Color3],[SK4-_Height1, SK5-_Height2, SK6-_Height3],C,H,'Height') :-
    SpaceSize is 28,
    RightPaddingSize is 25,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(2, ' '), format('Player 1\'s Objective -> Height',[]), draw_n(2,' '), format('Player 2\'s Objective -> Color',[]),put_code(0x2551), nl,
    draw_empty_lines(1,63,50),
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Big -> ~w', [SK4]), string_length_red(X,SK4), SpaceSize1 is SpaceSize - X,draw_n(SpaceSize1,' '), format('Red -> ~w', [SK1]), string_length_red(V,SK1), RightPaddingSize1 is RightPaddingSize - V,draw_n(RightPaddingSize1,' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Medium -> ~w', [SK5]), string_length_medium(Y,SK5), SpaceSize2 is SpaceSize - Y,draw_n(SpaceSize2,' '), format('Green -> ~w', [SK2]), string_length_green(M,SK2), RightPaddingSize2 is RightPaddingSize - M,draw_n(RightPaddingSize2,' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Small -> ~w', [SK6]), string_length_green(Z,SK6), SpaceSize3 is SpaceSize - Z,draw_n(SpaceSize3,' '), format('Blue -> ~w', [SK3]), string_length_blue(N,SK3), RightPaddingSize3 is RightPaddingSize - N, draw_n(RightPaddingSize3,' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), draw_n(10,'-'), draw_n(18,' '), draw_n(10,'-'), draw_n(15, ' '), put_code(0x2551), nl,
    draw_n(LeftMargin, ' '), put_code(0x2551), draw_n(10, ' '), format('Total -> ~w', [H]), draw_n(17,' '), format('Total -> ~w', [C]), draw_n(14, ' '), put_code(0x2551), nl.


% display_first_move_excpetion_computer_move(+Col,+Row,+Height,+Color) - displays the computer move
display_first_move_excpetion_computer_move(Col,Row,Height,Color) :-
    convert_column(NewCol,Col), convert_row(Row,NewRow),
    format('Computer 1\'s move: ~w-~w-~w-~w',[NewCol,NewRow,Height,Color]),nl.


% display_moving_move(+Player,+Col,+Row,+Squares,+Direction) - displays the computer move
display_moving_move(Player,Col,Row,Squares,Direction) :-
    convert_column(NewCol,Col),
    convert_row(Row,NewRow),
    format('Computer ~w\'s move is: ~w-~w-~w-~w',[Player,NewCol,NewRow,Squares,Direction]),nl.

% display_placing_move(+Player,+Height,+Color) - displays the computer move
display_placing_move(Player,Height,Color) :-
    format('Computer ~w\'s move is: ~w-~w',[Player,Height,Color]),nl.