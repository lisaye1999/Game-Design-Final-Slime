/// @description Insert description here
// You can write your code in this editor
if (draw_prompt_flag){
	//find if anything interactable exists infront of player; if so, display its prompt text.
	draw_set_halign(fa_middle);
	/*if(x > room_width - BOUNDARY_SPACE){
		var x_pos = room_width - BOUNDARY_SPACE;
	}
	else if(x < BOUNDARY_SPACE){
		x_pos = BOUNDARY_SPACE;
	}
	else{
		x_pos = x;
	}
	*/
	var x_pos = x;
	var y_pos = y + 30 + BOUNDARY_SPACE > room_height ? room_height-30 : y+30;
	draw_set_color(c_white)
	show_debug_message(view_camera[0])
	draw_text(x_pos-camera_get_view_x(view_camera[0]),y_pos-camera_get_view_y(view_camera[0]),interactable_object.prompt_text);
}