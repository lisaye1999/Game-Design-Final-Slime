/// @description Insert description here
// You can write your code in this editor

a = 0

global.go_to_ending_cutscene = false;
global.should_lola_appear = false;

#macro ENDING_NORMAL 0
#macro ENDING_BETRAYAL 1
#macro ENDING_CHOICE 2
#macro ENDING_CHOICE_BETRAYAL 3
#macro ENDING_SPECIAL 4

UNLOCK_ENDING_DAY = 42;
// defaults to this ending
ending = ENDING_NORMAL;

achi_requirement = array_create(0);
array_push(achi_requirement, 
obj_achievement_manager.achievement_list.FARMING_INTERMEDIATE);
array_push(achi_requirement, 
obj_achievement_manager.achievement_list.PASSION_IN_AGRICULTURE);
array_push(achi_requirement, 
obj_achievement_manager.achievement_list.BIG_SPENDER);

ending_setup = false;

has_met_Lola = false;
