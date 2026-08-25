:- use_module(library(lists)).
:- use_module(library(random)).
:- [output].
:- [input].
:- [utils].

% play/0 calls menu/0 to start the program
play :- menu.

% menu_options- initiates the program and draws the main menu.
menu :- draw_main_menu,
        main_menu_input(Input),
        menu_options(Input).

% menu_options(+Input) - Initiates the player vs player game
menu_options(1) :- 
    initial_state(InitialState), 
    before_game_input(Objective),
    create_player(Player1),
    create_player(Player2),
    first_move_exception(InitialState, Player1, Player2, 1, [],Objective).

% menu_options(+Input) - Initiates the player vs bot game
menu_options(2) :-
    initial_state(InitialState),
    pc_lvl_input(1, LvlPc1),
    before_game_input(Objective),
    create_player(Player1),
    create_player(Bot1),
    playervsbot_first_move_exception(InitialState, Player1, Bot1, 1, [], Objective, LvlPc1).

% menu_options(+Input) - Initiates the bot vs bot game
menu_options(3) :-
    initial_state(InitialState), 
    create_player(Bot1),
    create_player(Bot2),
    pc_lvl_input(1,LvlPc1),
    pc_lvl_input(2,LvlPc2),
    pc_obj_input(Obj),
    botvsbot_first_move_exception(InitialState,Bot1,Bot2,1,[],Obj,LvlPc1,LvlPc2).

% menu_options(+Input) - displays the game rules
menu_options(4) :-
    draw_rules,
    rules_input,
    menu.

% menu_options(+Input) - closes the game
menu_options(5) :- halt.

% valid_moving_moves(+GameState,+Pieces, -VMM) - generates all valid moves of moving type
/*
    GameState -> The current GameState
    Pieces -> The current Pieces on the board
    VMM -> List of all valid moving moves
*/
valid_moving_moves(GameState,Pieces, VMM) :- valid_moving_moves_helper(GameState,Pieces,VMM).

% valid_placing_moves(+Player,-VPM) generates all valid moves of placing type
/*
    Player -> The current state of Player (The number of Pieces of each type They have)
    VPM -> List of all valid placing moves
*/
valid_placing_moves(Player, VPM) :- valid_placing_moves_helper(Player,VPM).

% end_of_game(+GameState,+Pieces,+Objective) - checks whether the game has ended or not. If the there are less than 54 pieces then the game has not ended.
/*
    GameState -> The current GameState
    Pieces -> The current Pieces on the board
    Objective -> Player1's Objective
*/
end_of_game(_GameState,Pieces,_Objective) :- length(Pieces,X),X < 54, !.

% end_of_game(+GameState, +Pieces, +Objective) - checks whether the game has ended or not. If there are 54 pieces then the game has ended.
/*
    GameState -> The current GameState
    Pieces -> The current Pieces on the board
    Objective -> Player1's Objective
*/
end_of_game(GameState,Pieces,Objective) :-
    length(Pieces,X),X =:= 54, 
    game_over(GameState,Objective,_Winner).

% game_over(+GameState, +Objective, -Winner) - determines the winner by counting the biggest clusters of each player.
/*
    GameState -> The current GameState
    Objective -> Player1's Objective
    Winner -> The winner of the game
*/
game_over(GameState,Objective,Winner) :-
    display_game(GameState),
    bfs_helper(GameState,LC,LH),
    get_sum(LC,C),
    get_sum(LH,H),
    (H =:= C -> draw_draw(Objective,LC,LH,C,H); true),
    get_winner(Objective,H,C,Winner),
    draw_winner(Winner,LC,LH,C,H,Objective),
    menu.

% move(+GameState, +Col-Row-Squares-Direction, -NewGameState, +Type) - updates the board with a new move
/*
    GameState -> The current GameState
    Col-Row-Squares-Direction -> The Column and Row of where the piece is. The number Squares and direction in which the piece is going to be moved
    NewGameState -> The new GameState after the move
    Type -> The type of move. In this case a move that moves a piece.
*/
move(GameState, Col-Row-Squares-Direction,NewGameState,1) :-
    update_board_move(GameState,Col-Row-Squares-Direction,NewGameState).

% move(+GameState, +Col-Row-Height-Color, -NewGameState, +Type) - updates the board with a new move
/*
    GameState -> The current GameState
    Col-Row-Squares-Direction -> The Column and Row of where we want to place the piece. The number Height and Color of the piece to be placed.
    NewGameState -> The new GameState after the move
    Type -> The type of move. In this case a move that places a piece.
*/
move(GameState,Col-Row-Height-Color,NewGameState,2) :-
    update_board_place(GameState,Col-Row-Height-Color,NewGameState).

% first_move_exception(+GameState, +Player1, +Player2, +Player,+Pieces, +Objective) - responsible for handling the first move which is different from the other moves.
/*
    GameState -> The current GameState
    Player1 -> The current state of Player1 (The number of Pieces of each type They have)
    Player2 -> The current state of Player2 (The number of Pieces of each type They have)
    Player -> Whose Turn it is
    Pieces -> All the pieces currently on the board
    Objective -> Player1's objective
*/
first_move_exception(GameState, Player1,Player2, Player, Pieces, Objective) :-
    display_game(GameState,Player,Player1),
    first_move_exception_input(Col-Row-Height-Color,Player),
    update_player(Player1,Height-Color,NewPlayer1),
    track_pieces(Col,Row,Pieces,NewPieces),
    switch_turn(Player,NewPlayer),
    move(GameState,Col-Row-Height-Color, NewGameState,2),
    game_loop(NewGameState,NewPlayer1,Player2,NewPlayer,NewPieces,Objective).

% game_loop(+GameState, +Player1, +Player2, +Player,+ Pieces, +Objective) - responsible for the player vs player main loop.
/*
    GameState -> The current gameState
    Player1 -> The current state of Player1 (The number of Pieces of each type They have)
    Player2 -> The current state of Player2 (The number of Pieces of each type They have)
    Player -> Whose Turn it is
    Pieces -> All the pieces currently on the board
    Objective -> Player1's objective
*/
game_loop(GameState,Player1,Player2,Player,Pieces,Objective) :-
    end_of_game(GameState,Pieces,Objective),
    (Player =:= 1 -> display_game(GameState,Player,Player1) ; display_game(GameState,Player,Player2)),
    valid_moving_moves(GameState,Pieces,VMM),
    move_moving_input(Col-Row-Squares-Direction,Player,VMM),
    move(GameState,Col-Row-Squares-Direction,NewGameState,1),
    display_game(NewGameState),
    track_pieces(Col,Row,Pieces,NewPieces,Squares-Direction),
    (Player =:= 1 -> valid_placing_moves(Player1,VPM); valid_placing_moves(Player2,VPM)),
    move_placing_input(Height-Color,Player, VPM),
    move(NewGameState,Col-Row-Height-Color,LastGameState,2),
    (Player =:= 1 -> update_player(Player1,Height-Color,NewPlayer1); update_player(Player2,Height-Color,NewPlayer2)),
    track_pieces(Col,Row,NewPieces,LastPieces),
    switch_turn(Player, NewPlayer),
    (Player =:= 1 -> game_loop(LastGameState,NewPlayer1,Player2,NewPlayer, LastPieces,Objective); game_loop(LastGameState,Player1,NewPlayer2,NewPlayer, LastPieces,Objective)).

% choose_move(+GameState, +BotLevel, -Col-Row-Squares-Direction-Height-Color, +Pieces, +Bot, +Objective) - responsible for choosing a move for the computer.
/*
    GameState -> The current GameState
    BotLevel -> The Level of the Computer
    Col-Row-Squares-Direction-Height-Color -> The move which the bot chose
    Pieces -> All the pieces currently on the board
    Bot -> The current state of Bot (The number of Pieces of each type They have)
    Objective -> Player1's objective
*/
choose_move(GameState,1,Col-Row-Squares-Direction-Height-Color,Pieces,Bot,_Objective) :-
    select_random_piece_to_move(GameState,Pieces,Col-Row),
    valid_moving_moves(GameState,Pieces,VMM),
    select_random_available_move(Col-Row,VMM,Squares-Direction),
    valid_placing_moves(Bot,VPM),
    select_random_tree(VPM,Height-Color).

% choose_move(+GameState, +BotLevel, -Col-Row-Squares-Direction-Height-Color, +Pieces, +Bot, +Objective) - responsible for choosing a move for the computer.
/*
    GameState -> The current GameState
    BotLevel -> The Level of the Computer
    Col-Row-Squares-Direction-Height-Color -> The move which the bot chose
    Pieces -> All the pieces currently on the board
    Bot -> The current state of Bot (The number of Pieces of each type They have)
    Objective -> Player1's objective
*/
choose_move(GameState,2,Col-Row-Squares-Direction-Height-Color,Pieces,Bot,Objective) :-
    select_best_move(GameState,Col-Row,Squares-Direction,Height-Color,Pieces,Bot,Objective).

% value(+GameState,-Value) - evaluates the current state of the game
/*
    GameState -> Current State
    Value -> The current Value of the GameState
*/
value(GameState,Value) :-
    value_helper(GameState,Value).

% playervsbot_first_move_exception(+GameState, +Player1, +Bot1, +Player,+Pieces, +Objective, +Bot1Lvl) - responsible for handling the first move which is different from the other moves.
/*
    GameState -> The current GameState
    Player1 -> The current state of Player1 (The number of Pieces of each type They have)
    Bot1 -> The current state of Bot1 (The number of Pieces of each type They have)
    Player -> Whose Turn it is
    Pieces -> All the pieces currently on the board
    Objective -> Player1's objective
    Bot1Lvl -> The level of the computer
*/
playervsbot_first_move_exception(GameState, Player1, Bot1, Player, Pieces, Objective, _Bot1lvl) :-
    display_game(GameState, Player, Player1),
    first_move_exception_input(Col-Row-Height-Color,Player),
    update_player(Player1,Height-Color,NewPlayer1),
    track_pieces(Col,Row,Pieces,NewPieces),
    switch_turn(Player,NewPlayer),
    move(GameState,Col-Row-Height-Color, NewGameState,2),
    playervsbot_loop(NewGameState,NewPlayer1,Bot1,NewPlayer,NewPieces,Objective,_Bot1lvl).

% playervsbot_loop(+GameState, +Player1, +Bot1, +Player,+ Pieces, +Objective, +Bot1Lvl) - responsible for the player vs bot main loop.
/*
    GameState -> The current gameState
    Player1 -> The current state of Player1 (The number of Pieces of each type They have)
    Player2 -> The current state of Player2 (The number of Pieces of each type They have)
    Player -> Whose Turn it is
    Pieces -> All the pieces currently on the board
    Objective -> Player1's objective
    Bot1Lvl -> The level of the computer
*/
playervsbot_loop(GameState,Player1,Bot1,Player,Pieces,Objective,Bot1lvl) :-
    end_of_game(GameState,Pieces,Objective),
    (Player =:= 1 ->
        display_game(GameState,Player,Player1),
        valid_moving_moves(GameState,Pieces,VMM),
        move_moving_input(Col-Row-Squares-Direction,Player,VMM),
        move(GameState,Col-Row-Squares-Direction,NewGameState,1),
        display_game(NewGameState),
        track_pieces(Col,Row,Pieces,NewPieces,Squares-Direction),
        valid_placing_moves(Player1,VPM),
        move_placing_input(Height-Color,Player, VPM),
        move(NewGameState,Col-Row-Height-Color,LastGameState,2),
        update_player(Player1,Height-Color,NewPlayer1),
        track_pieces(Col,Row,NewPieces,LastPieces),
        switch_turn(Player, NewPlayer),
        playervsbot_loop(LastGameState,NewPlayer1,Bot1,NewPlayer,LastPieces,Objective,Bot1lvl);
        display_game(GameState,Player,Bot1),
        (Objective = 'Color' -> SecObj = 'Height'; SecObj = 'Color'),
        choose_move(GameState,Bot1lvl,Col-Row-Squares-Direction-Height-Color,Pieces,Bot1,SecObj),
        move(GameState,Col-Row-Squares-Direction,NewGameState,1),
        display_moving_move(Player,Col,Row,Squares,Direction),
        display_game(NewGameState),
        track_pieces(Col,Row,Pieces,NewPieces,Squares-Direction),
        display_placing_move(Player,Height,Color),
        move(NewGameState,Col-Row-Height-Color,LastGameState,2),
        update_player(Bot1,Height-Color,NewBot1),
        track_pieces(Col,Row,NewPieces,LastPieces),
        switch_turn(Player,NewPlayer),
        playervsbot_loop(LastGameState,Player1,NewBot1,NewPlayer,LastPieces,Objective,Bot1lvl)).

% playervsbot_first_move_exception(+GameState, +Bot1, +Bot2, +Player,+Pieces, +Objective, +Bot1Lvl, +Bot2Lvl) - responsible for handling the first move which is different from the other moves.
/*
    GameState -> The current GameState
    Bot1 -> The current state of Bot1 (The number of Pieces of each type They have)
    Bot2 -> The current state of Bot2 (The number of Pieces of each type They have)
    Player -> Whose Turn it is
    Pieces -> All the pieces currently on the board
    Objective -> Player1's objective
    Bot1Lvl -> The level of the first computer
    Bot2Lvl -> The level of the second computer
*/
botvsbot_first_move_exception(GameState,Bot1,Bot2,Player,Pieces,Objective,_Bot1lvl, _Bot2lvl) :-
    display_game(GameState,Player,Bot1),
    valid_placing_moves(Bot1, VPM),
    select_random_tree(VPM,Height-Color),
    select_random_grid_slot(Col-Row),
    display_first_move_excpetion_computer_move(Col,Row,Height,Color),
    track_pieces(Col,Row,Pieces,NewPieces),
    update_player(Bot1,Height-Color,NewBot1),
    switch_turn(Player,NewPlayer),
    move(GameState,Col-Row-Height-Color, NewGameState,2),
    botvsbot_loop(NewGameState,NewBot1,Bot2,NewPlayer,NewPieces,Objective,_Bot1lvl,_Bot2lvl).

% botvsbot_loop(+GameState, +Bot1, +Bot2, +Player,+ Pieces, +Objective, +Bot1Lvl, +Bot2Lvl) - responsible for the bot vs bot main loop.
/*
    GameState -> The current gameState
    Bot1 -> The current state of Bot1 (The number of Pieces of each type They have)
    Bot2 -> The current state of Bot2 (The number of Pieces of each type They have)
    Player -> Whose Turn it is
    Pieces -> All the pieces currently on the board
    Objective -> Player1's objective
    Bot1Lvl -> The level of the first computer
    Bot2Lvl -> The level of the second computer
*/
botvsbot_loop(GameState,Bot1,Bot2,Player,Pieces,Objective,Bot1lvl, Bot2lvl) :-
    end_of_game(GameState,Pieces,Objective),
    (Player =:= 1 -> display_game(GameState,Player,Bot1) ; display_game(GameState,Player,Bot2)),
    (Objective = 'Color' -> SecObj = 'Height'; SecObj = 'Color'),
    (Player =:= 1 -> choose_move(GameState,Bot1lvl,Col-Row-Squares-Direction-Height-Color,Pieces,Bot1,Objective) ; choose_move(GameState,Bot2lvl,Col-Row-Squares-Direction-Height-Color,Pieces,Bot2,SecObj)),
    move(GameState,Col-Row-Squares-Direction,NewGameState,1),
    display_moving_move(Player,Col,Row,Squares,Direction),
    display_game(NewGameState),
    track_pieces(Col,Row,Pieces,NewPieces,Squares-Direction),
    display_placing_move(Player,Height,Color),
    move(NewGameState,Col-Row-Height-Color,LastGameState,2),
    (Player =:= 1 -> update_player(Bot1,Height-Color,NewBot1); update_player(Bot2,Height-Color,NewBot2)),
    track_pieces(Col,Row,NewPieces,LastPieces),
    switch_turn(Player, NewPlayer),
    (Player =:= 1 -> botvsbot_loop(LastGameState,NewBot1,Bot2,NewPlayer, LastPieces,Objective,Bot1lvl,Bot2lvl); botvsbot_loop(LastGameState,Bot1,NewBot2,NewPlayer, LastPieces,Objective,Bot1lvl,Bot2lvl)).