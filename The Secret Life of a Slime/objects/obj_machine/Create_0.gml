 /// @description Insert description here
// You can write your code in this editor

event_inherited()

interactable = true; // false when we are at town
// statuses are: "empty", "busy", "full", "broken", "repairing"
status = "empty";

//is_converting = false;
amount_to_convert = 0;
time_to_convert = 10;
time_left = time_to_convert;
full_signal = true;		// keep track of exclamation signal status

this_machine = id;

//prompt text
prompt_text_lst = ["use machine? (" + string(convert_from_count) +" "+convert_from.name+")",
	"converting...", 
	"collect the "+convert_to.name+"?",
	"repair machine? (1 parts) ("+ string(ENERGY_COST_TO_REPAIR) +" energy)"]
which_text = 0;

