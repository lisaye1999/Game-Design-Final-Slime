/// @description Insert description here
// You can write your code in this editor

image_speed = 0.15;

if(obj_game_ending_manager.ending == ENDING_CHOICE){
	visible = true;
	x = 721;
	y = 377;
}
else if(obj_game_ending_manager.ending == ENDING_SPECIAL){
	visible = true;
	x = 783;
	y = 377;
}
else{
	visible = false;
}
