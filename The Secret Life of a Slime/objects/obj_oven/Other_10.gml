/// @description Insert description here
// You can write your code in this editor
show_debug_message("daily check for oven triggered")
if (global.days>=global.advanced_machine_unlock_day){
	should_be_interactable = true;
	interactable = true;
	solid = true;
	visible = true;
	ds_map_delete(obj_game_manager.objects_with_daily_events,id)
}