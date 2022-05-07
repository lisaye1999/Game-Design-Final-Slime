/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Can not interact with chest if game is paused
if (obj_storage_manager.storage_open) {
	obj_storage_manager.storage_open = false;
	global.unpause_signal = true;
}
else {
	obj_storage_manager.storage_open = true;
	global.paused = true;
	audio_play_sound(sfx_str_open, 0, false);
}



