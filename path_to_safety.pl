% moves
move([A,B],[D,B],up):-
 D is A-1.
move([A,B],[C,B],down):-
 C is A+1.
move([A,B],[A,E],left):-
 E is B-1.
move([A,B],[A,F],right):-
 F is B+1.
%check if the sequence is valid

invalid([A,B]):-
dim(X,Y),
(( A >= X -> (A is A); (A <0));
(B >= Y -> (B is B); (B < 0))).
%dim(X,Y), A >=X , A <0 ,B <0 ,B >=Y.

unsafe(State):-
bomb(State).

%collect starts
collect(State,[X|Y],S2):-
star(State),
S2 is X+1.
collect(State,[X|Y],S2):-
\+ star(State),
S2 is X.

path(Current,_,G,[X|Y],G,X):-end(Current).

path(State,Visted,G,S,Moves,Stars):-
move(State,Nextstate,Direction),
\+ member(Nextstate,Visted),
\+ invalid(Nextstate),
\+ unsafe(Nextstate),
collect(State,S,S2),
append(G, [Direction], NewDirections),
path(Nextstate,[Nextstate|Visted],NewDirections,[S2|S],Moves,Stars).

play(M,S):-
start(State),
path(State,[State],[],[0],M,S).