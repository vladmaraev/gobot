satisfy(agenda) :-
  perform(requestInfo(reason)),
  satisfy(reason),
  write('( SOLVED )'), nl. %, halt.

satisfy(reason) :-
  valueOf(reason,other),
  perform(inform(solved_agent_transfer_general)).

satisfy(reason) :-
  valueOf(reason,stb_connection),
  perform(requestInfo(on_screen)),
  satisfy(on_screen).

satisfy(on_screen) :- 
  valueOf(on_screen, firmware_not_found),
  satisfy(firmware_not_found).

satisfy(on_screen) :-
  valueOf(on_screen, core_module_load_problem),
  satisfy(core_module_load_problem).

satisfy(on_screen) :-
  valueOf(on_screen, server_not_found),
  satisfy(server_not_found).

satisfy(on_screen) :-
  valueOf(on_screen, black_screen_with_coloured_circles),
  satisfy(server_not_found).

%% firmware_not_found

satisfy(firmware_not_found) :- 
  perform(requestAction(connect_stb_directly)),
  perform(requestInfoYN(does_it_work_now_1)),
  satisfy(does_it_work_now_1).

satisfy(does_it_work_now_1) :-
  valueOf(does_it_work_now_1, yes),
  perform(inform(solved_close_ticket_firmware_not_found)).

satisfy(does_it_work_now_1) :- 
  valueOf(does_it_work_now_1, no),
  perform(requestAction(dont_switch_off)),
  perform(inform(solved_iptv_transfer)).

%% core_module_load_problem

satisfy(core_module_load_problem) :- 
  perform(requestAction(connect_stb_directly)),
  perform(requestInfoYN(does_it_work_now_2_1)),
  satisfy(does_it_work_now_2_1).

satisfy(does_it_work_now_2_1) :-
  valueOf(does_it_work_now_2_1, yes),
  perform(inform(solved_close_ticket_core_module_load_problem)).

satisfy(does_it_work_now_2_1) :-
  valueOf(does_it_work_now_2_1, no),
  satisfy(consult_reload_firmware).

satisfy(consult_reload_firmware) :-
  perform(requestAction(consult_reload_firmware)),
  perform(requestInfoYN(does_it_work_now_2_2)),
  satisfy(does_it_work_now_2_2).

satisfy(does_it_work_now_2_2) :-
  valueOf(does_it_work_now_2_2, yes),
  perform(inform(solved_close_ticket_core_module_load_problem)).

satisfy(does_it_work_now_2_2) :-
  valueOf(does_it_work_now_2_2, no),
  perform(inform(solved_iptv_transfer)).

%% server_not_found

satisfy(server_not_found) :- 
  perform(requestInfoYN(does_internet_work)),
  satisfy(does_internet_work).

satisfy(does_internet_work) :-
  valueOf(does_internet_work, no),
  perform(inform(solved_internet_transfer)).

satisfy(does_internet_work) :-
  valueOf(does_internet_work, yes),
  satisfy(connect_stb_directly_3).

satisfy(connect_stb_directly_3) :- 
  perform(requestAction(connect_stb_directly_3)),
  perform(requestInfoYN(does_it_work_now_3)),
  satisfy(does_it_work_now_3).

satisfy(does_it_work_now_3) :-
  valueOf(does_it_work_now_3, yes),
  perform(inform(solved_close_ticket_server_not_found)).

satisfy(does_it_work_now_3) :- 
  valueOf(does_it_work_now_3, no),
  perform(requestAction(dont_switch_off)),
  perform(inform(solved_iptv_transfer)).


