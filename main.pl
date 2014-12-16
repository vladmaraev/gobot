:- dynamic valueOf/2, perform/1.

%
%  Speech Act Structure
%

agentSA( requestAction( _)).
agentSA( requestInfo( _)).
agentSA( requestInfoYN( _)).
agentSA( groundStatus( _)).
agentSA( inform( _)).
agentSA( acknowledge).

userSA( inform( _)).
userSA( inform_yes).
userSA( inform_no).
userSA( acknowledge).
userSA( please_clarify).
userSA( please_wait).

replies( inform( _), requestInfo( _)).
replies( inform_yes, requestInfoYN(_)).
replies( inform_no, requestInfoYN(_)).
replies( acknowledge, requestAction( _)).
replies( acknowledge, groundStatus( _)).
replies( please_clarify, _) :- agentSA( _), !.
replies( please_wait, _) :- agentSA( _), !.

verified(UserSA, AgentSA) :- 
  userSA(UserSA),
  replies(UserSA, AgentSA).

%
% THE ALGORITHM
%

perform(AgentSA) :- 
  AgentSA = inform( _),
  write('A: '), write(AgentSA), write('.'), nl, 
  %% asserta(perform(AgentSA)),
  write('( performed '), write(AgentSA), write(' )'), nl, !.

perform(AgentSA) :-
  write('A: '), write(AgentSA), write('?'), nl, 
  write('U: '), read(UserSA), consider(UserSA, AgentSA), 
  perform(AgentSA).

consider(UserSA, AgentSA) :-
  not(verified(UserSA, AgentSA)), 
  write('( invalid userSA )'), nl,
  !.

consider(UserSA, _) :-
  UserSA = please_clarify,
  write('( is explanation available? )'), nl, fail.

consider(UserSA, AgentSA) :-
  AgentSA = requestAction(_),
  UserSA = acknowledge,
  asserta(perform(AgentSA)),
  write('( performed '), write(AgentSA), write(' )'), nl.

consider(UserSA, AgentSA) :-
  AgentSA = requestInfo(_),
  UserSA = inform(valueOf(A,B)),
  asserta(perform(AgentSA)),
  write('( performed '), write(AgentSA), write(' )'), nl,
  asserta(valueOf(A,B)),
  write('( got value: '), write(A), write('='), write(B), write(' )'), nl.

consider(UserSA, AgentSA) :-
  AgentSA = requestInfoYN(A),
  UserSA = inform_no,
  asserta(perform(AgentSA)),
  write('( performed '), write(AgentSA), write(' )'), nl,
  asserta(valueOf(A,no)),
  write('( got value: '), write(A), write('= no'), write(' )'), nl.

consider(UserSA, AgentSA) :-
  AgentSA = requestInfoYN(A),
  UserSA = inform_yes,
  asserta(perform(AgentSA)),
  write('( performed '), write(AgentSA), write(' )'), nl,
  asserta(valueOf(A,yes)),
  write('( got value: '), write(A), write('= yes'), write(' )'), nl.

%
% THE AGENDA
%  

:- [agenda].








