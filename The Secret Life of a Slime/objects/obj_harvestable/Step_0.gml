/// @description Insert description here
// You can write your code in this editor
depth = -y;


if(!ready && !growing){
	growing = true;
	
	if (global.tutorial_ended_farm) {
		grow_time_remaining = irandom_range(MIN_GROWTH_TIME, MAX_GROWTH_TIME);
	}
	else {
		grow_time_remaining = 5;
	}
}

if(grow_time_remaining>0){
	if(growing) {
		prompt_text = "The "+harvest.name+" is still growing (" + string(floor(grow_time_remaining)) + "s)";
		grow_time_remaining -= global.delta_second;	
		image_index = floor((MAX_GROWTH_TIME - grow_time_remaining) / interval)
	}
}
else{
	image_index = 3;
}
if(growing && grow_time_remaining <= 0){
	ready = true;
	growing = false;
	prompt_text = "Pick "+harvest.name+"?";
	with (instance_create_depth(x - sprite_width/2,y - sprite_height/2,depth-1,obj_sparkle)){
		roomAssigned = other.created_room;
	};
}
