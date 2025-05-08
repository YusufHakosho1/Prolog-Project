% family.pl — Friendly Family Tree Project
% ----------------------------------------
% Load & run:
%   swipl -q -l family.pl
% The menu will appear immediately.

:- use_module(library(readutil)).  % for read_line_to_string/2

%--------------------
% Facts
%--------------------
male(john).   male(bob).     male(tom).     male(dick).
male(charles). male(james).   male(oliver).  male(sam).
male(eugene). male(george).

female(mary).  female(sue).    female(liz).    female(anna).
female(martha). female(nina).   female(peggy).  female(hannah).
female(fiona). female(elizabeth). female(philip_spouse). % placeholder spouse

parent(john, mary).
parent(john, bob).
parent(mary, susan).
parent(bob, alice).
parent(tom, liz).
parent(dick, anna).

% Additional families to expand relationships
parent(john, susan).
parent(john, alice).

parent(charles, james).
parent(charles, oliver).
parent(martha, james).
parent(martha, oliver).

parent(james, sam).
parent(nina, sam).

parent(eugene, george).
parent(eugene, hannah).
parent(fiona, george).
parent(fiona, hannah).

% Grandparents for Eugene & Fiona
parent(elizabeth, eugene).
parent(philip_spouse, eugene).
parent(elizabeth, fiona).
parent(philip_spouse, fiona).

%--------------------
% Derived rules
%--------------------
father(X,Y)      :- parent(X,Y), male(X).
mother(X,Y)      :- parent(X,Y), female(X).
grandparent(X,Y) :- parent(X,Z), parent(Z,Y).
sibling(X,Y)     :- parent(Z,X), parent(Z,Y), X \= Y.
ancestor(X,Y)    :- parent(X,Y).
ancestor(X,Y)    :- parent(X,Z), ancestor(Z,Y).

% Anyone mentioned in facts
person(P) :-
   male(P); female(P); parent(P,_); parent(_,P).

%--------------------
% Entry point
%--------------------
:- initialization(main).

main :-
    write('*** Welcome to the Family Tree Program ***'), nl, nl,
    menu_loop.

%--------------------
% Menu loop
%--------------------
menu_loop :-
    % Display options
    write('1. List all fathers'),          nl,
    write('2. List all mothers'),          nl,
    write('3. List all grandparents'),     nl,
    write('4. List all siblings'),         nl,
    write('5. List all ancestors'),        nl,
    write('6. List all people'),           nl,
    write('7. Check a relationship'),      nl,
    write('8. Print family tree'),         nl,
    write('9. Exit'),                      nl,
    write('Enter choice (1-9): '),
    % Read line as string, convert to number (or 0 on failure)
    read_line_to_string(user_input, S), 
    ( atom_number(S, Choice) -> true ; Choice = 0 ),
    nl,
    % Handle it
    handle_choice(Choice),
    ( Choice =:= 9 -> true ; nl, menu_loop ).

%--------------------
% Dispatch & handlers
%--------------------
handle_choice(1) :- list_all(father,      'Fathers').
handle_choice(2) :- list_all(mother,      'Mothers').
handle_choice(3) :- list_all(grandparent, 'Grandparents').
handle_choice(4) :- list_all(sibling,     'Siblings').
handle_choice(5) :- list_all(ancestor,    'Ancestors').
handle_choice(6) :- list_people.
handle_choice(7) :- check_relationship.
handle_choice(8) :- print_tree_prompt.
handle_choice(9) :- write('Goodbye!'), nl.
handle_choice(_) :-
    write('Invalid option. Please enter a number from 1 to 9.'), nl.

%--------------------
% Listers
%--------------------
list_all(Rel, Title) :-
    format('--- ~w ---~n', [Title]),
    findall((X,Y), call(Rel,X,Y), Pairs),
    ( Pairs == [] ->
        write('(none)'), nl
    ; forall(member((A,B), Pairs),
             format('  ~w is ~w of ~w~n', [A,Rel,B]))
    ).

list_people :-
    findall(P, person(P), Ps0),
    sort(Ps0, Ps),
    write('People in database: '), write(Ps), nl.

%--------------------
% Check one relationship
%--------------------
check_relationship :-
    write('Enter relationship name (father, mother, grandparent, sibling, ancestor): '),
    read_line_to_string(user_input, Srel), atom_string(Rel, Srel),
    ( member(Rel, [father,mother,grandparent,sibling,ancestor]) ->
        write('First person: '), read_line_to_string(user_input, S1), atom_string(P1, S1),
        write('Second person: '), read_line_to_string(user_input, S2), atom_string(P2, S2),
        Goal =.. [Rel,P1,P2],
        ( call(Goal) ->
            format('Yes: ~w(~w,~w) is true.~n', [Rel,P1,P2])
        ;   format('No:  ~w(~w,~w) is false.~n', [Rel,P1,P2])
        )
    ; write('Unknown relationship. Try again.'), nl
    ).

%--------------------
% Print descendant tree
%--------------------
print_tree_prompt :-
    write('Enter person name: '),
    read_line_to_string(user_input, Sname), atom_string(Name, Sname),
    ( person(Name) ->
        format('Family tree of ~w:~n', [Name]),
        print_tree(Name, 0)
    ;   format('No such person: ~w~n', [Name])
    ).

print_tree(Person, Indent) :-
    tab(Indent), writeln(Person),
    Next is Indent + 4,
    findall(C, parent(Person,C), Children),
    forall(member(C,Children), print_tree(C, Next)).