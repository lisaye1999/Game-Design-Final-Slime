/// @description Insert description here
// You can write your code in this editor

// player cannot perform actions during room transitions
if not (global.dead or global.paused or instance_exists(obj_room_transition)) {
	depth = -y;
	
	if !global.tutorial_restrict {
		key_up = keyboard_check(vk_up);
		key_right = keyboard_check(vk_right);
		key_down = keyboard_check(vk_down);
		key_left = keyboard_check(vk_left);
		key_z = keyboard_check_pressed(ord("Z"));

		key_1 = keyboard_check_pressed(ord("1"));
		key_2 = keyboard_check_pressed(ord("2"));
		key_3 = keyboard_check_pressed(ord("3"));
		key_4 = keyboard_check_pressed(ord("4"));
		key_5 = keyboard_check_pressed(ord("5"));
		key_6 = keyboard_check_pressed(ord("6"));
		key_7 = keyboard_check_pressed(ord("7"));
		key_8 = keyboard_check_pressed(ord("8"));
		key_9 = keyboard_check_pressed(ord("9"));
		key_0 = keyboard_check_pressed(ord("0"));

		// ** Movement ** //

		x_speed = (key_right - key_left) * move_spd;
		y_speed = (key_down - key_up) * move_spd;
	}
	
	

	// set sprite direction	
	if(y_speed > 0) {face = DOWN;}
	if(y_speed < 0) {face = UP;}
	if(x_speed > 0) {face = RIGHT;}
	if(x_speed < 0) {face = LEFT;}
	sprite_index = sprite[face]
	//if(x+x_speed > room_width || x+x_speed < 0){
	/*if(x+x_speed > room_width){
		x_speed = 0;
	}
	if(y+y_speed < 0 || y+y_speed >  room_height){
		y_speed = 0;
	}*/
	
	footstep_audio_count += 1;
	footstep_audio_count = footstep_audio_count mod footstep_audio_reset;
	
	if (((x_speed != 0) || (y_speed != 0)) && (footstep_audio_count == 0)) {
		// play footstep sfx
		// audio_play_sound(sfx_footsteps, 0, false);
		// maybe add squelching sound as well
		if(sprite == human_sprite){
			audio_sound_set_track_position(sfx_footsteps, 0.2);
			audio_play_sound(sfx_footsteps, 0, false);
		}
		else{
			audio_play_sound(sfx_slime_splat, 0, false);
		}
	}
	
	// move the player

	//this code is not working. commenting out::
	/*
	// move camera left when player walks off screen
	if (x < camera_get_view_x(cam)){
		//view_x -= view_width;	// i think this is shifting by an entire screen width
		//show_debug_message("player pos: " + string(x) + ", cam pos: " + string(camera_get_view_x(cam)));
		camera_set_view_pos(cam, camera_get_view_x(cam) - camera_get_view_width(cam)/2, camera_get_view_y(cam));
	}
	if(x > camera_get_view_x(cam) + camera_get_view_width(cam)) {
		camera_set_view_pos(cam, camera_get_view_x(cam) + camera_get_view_width(cam)/2, camera_get_view_y(cam));
	}
	
	// move camera down when player walks below screen
	if (y < camera_get_view_y(cam)){
		//show_debug_message("player pos: " + string(y) + ", cam pos: " + string(camera_get_view_y(cam)));
		camera_set_view_pos(cam, camera_get_view_x(cam), camera_get_view_y(cam) - camera_get_view_height(cam)/2);
	}
	if (y > camera_get_view_y(cam) + camera_get_view_height(cam)){
		camera_set_view_pos(cam, camera_get_view_x(cam), camera_get_view_y(cam) + camera_get_view_height(cam)/2);
	}
	*/
	
	
	//check if stuck, skip collision check if already stuck
	var _curr_location_instance = find_first_interactable(obj_solid,x,y);
	if (!(_curr_location_instance != noone && _curr_location_instance.solid)){
		// set collision for solid
		var x_check = find_first_interactable(obj_solid,x+x_speed, y);
		if(x_check!=noone && x_check.solid){
			x_speed = 0;
		}
		var y_check = find_first_interactable(obj_solid,x, y+y_speed)
		if(y_check!=noone && y_check.solid){
			y_speed = 0;
		}
	}
	x += x_speed;
	y += y_speed;
	// ** Interaction ** //
	if(place_meeting(x, y, obj_prompt_town) && key_z && !instance_exists(obj_room_transition)){
		if(global.has_reached_ending){
			create_textbox("ending_town_lock");
		}
		else{
			go_to_town(self);
		}
	}
	if(place_meeting(x,y, obj_prompt_home) && key_z && !instance_exists(obj_room_transition)){
		go_home(self);
	}
	
	if !global.tutorialBedDone and place_meeting(x, y, obj_tutorial_check) {
		global.touchedBed = true;
		global.tutorialBedDone = true;
	}

	//interact with interactables
	var _interact_check_x = x + DIR[face][0]*10;
	var _interact_check_y = y + DIR[face][1]*10;
	last_interactable_object = interactable_object;
	interactable_object = find_first_interactable(obj_solid_interactable,_interact_check_x,_interact_check_y)
	if (interactable_object!=noone){
		if (interactable_object!=last_interactable_object){
			draw_prompt_flag = true;
		}
	}
	else {
		draw_prompt_flag = false;
	}

	// for interactables which use inventory slots instead of generic z key
	// (farm plots and machines)
	if (interactable_object != noone && instance_exists(interactable_object) && interactable_object.uses_inventory){
		inv = obj_inventory_manager.inventory
		inv_count = array_length(inv);
		if (key_1 && inv_count >= 1){
			interactable_object.inv_slot = 1;
			interactable_object.alarm[0] = 1;
			draw_prompt_flag = false;
		} else if (key_2 && inv_count >= 2){
			interactable_object.inv_slot = 2;
			interactable_object.alarm[0] = 1;
			draw_prompt_flag = false;
		} else if (key_3 && inv_count >= 3){
			interactable_object.inv_slot = 3;
			interactable_object.alarm[0] = 1;
			draw_prompt_flag = false;
		} else if (key_4 && inv_count >= 4){
			interactable_object.inv_slot = 4;
			interactable_object.alarm[0] = 1;
			draw_prompt_flag = false;
		} else if (key_5 && inv_count >= 5){
			interactable_object.inv_slot = 5;
			interactable_object.alarm[0] = 1;
			draw_prompt_flag = false;
		} else if (key_6 && inv_count >= 6){
			interactable_object.inv_slot = 6;
			interactable_object.alarm[0] = 1;
			draw_prompt_flag = false;
		} else if (key_7 && inv_count >= 7){
			interactable_object.inv_slot = 7;
			interactable_object.alarm[0] = 1;
			draw_prompt_flag = false;
		} else if (key_8 && inv_count >= 8){
			interactable_object.inv_slot = 8;
			interactable_object.alarm[0] = 1;
			draw_prompt_flag = false;
		} else if (key_9 && inv_count >= 9){
			interactable_object.inv_slot = 9;
			interactable_object.alarm[0] = 1;
			draw_prompt_flag = false;
		} else if (key_0 && inv_count >= 10){
			interactable_object.inv_slot = 10;
			interactable_object.alarm[0] = 1;
			draw_prompt_flag = false;
		} else if(key_z){
			interactable_object.alarm[1] = 1;
			// create_textbox("warn-use-number")
			
		}
	}
	//********
	
	// use regular interactables
	else if (key_z && interactable_object != noone && instance_exists(interactable_object)){
		interactable_object.alarm[0] = 1;
		draw_prompt_flag = false;
	}
	
	
	// using items
	if(interactable_object == noone || (interactable_object != noone && !interactable_object.uses_inventory)){
		inv = obj_inventory_manager.inventory
		inv_count = array_length(inv);
		if(key_1 && inv_count >= 1){
			use_item(inv[0]);
		}
		if(key_2 && inv_count >= 2){
			use_item(inv[1]);
		}
		if(key_3 && inv_count >= 3){
			use_item(inv[2]);
		}
		if(key_4 && inv_count >= 4){
			use_item(inv[3]);
		}
		if(key_5 && inv_count >= 5){
			use_item(inv[4]);
		}
		if(key_6 && inv_count >= 6){
			use_item(inv[5]);
		}
		if(key_7 && inv_count >= 7){
			use_item(inv[6]);
		}
		if(key_8 && inv_count >= 8){
			use_item(inv[7]);
		}
		if(key_9 && inv_count >= 9){
			use_item(inv[8]);
		}
		if(key_0 && inv_count >= 10){
			use_item(inv[9]);
		}
	}


	function use_item(item){
		switch(item.name){
			case global.item_list.berries.name:
				audio_play_sound(sfx_eat_item, 0, false);
				increase_energy(4);
				lose_one_item(item);
				break;
			case global.item_list.slime_jelly.name:
				audio_play_sound(sfx_eat_item, 0, false);
				increase_energy(25);
				lose_one_item(item);
				achi_gain_progress("DONT_STARVE", 1);
				break;
			case global.item_list.fish.name:
				audio_play_sound(sfx_eat_item, 0, false);
				increase_energy(6);
				lose_one_item(item);
				break;
			case global.item_list.stars.name:
				audio_play_sound(sfx_eat_item, 0, false);
				increase_energy(30);
				lose_one_item(item);
				break;
			case global.item_list.gummy_bear.name:
				audio_play_sound(sfx_eat_item, 0, false);
				increase_energy(50);
				lose_one_item(item);
				break;
			default:
				create_textbox("warn-cannot-use-item");
				return;
		}
	}
	
	function increase_energy(amount){
		newAmount = amount + global.energy;
		global.energy = newAmount > global.energy_max ? global.energy_max : newAmount;
	}
	
	// hacky way of gaining more seeds
	//commenting this out for final version
	/*
	if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("W"))){
		gain_one_item(global.item_list.wheat_seeds);		// gain wheat seeds
	} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("C"))){
		gain_one_item(global.item_list.carrot_seeds);		// gain carrot seeds
	//} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("F"))){
	//	gain_one_item(global.item_list.cauliflower_seeds);		// gain cauliflower seeds
	} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("U"))){
		gain_one_item(global.item_list.cucumber_seeds);		// gain cucumber seeds
	//} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("G"))){
	//	gain_one_item(global.item_list.eggplant_seeds);		// gain eggplant seeds
	} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("L"))){
		gain_one_item(global.item_list.lettuce_seeds);		// gain lettuce seeds
	} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("P"))){
		gain_one_item(global.item_list.pumpkin_seeds);		// gain pumpkin seeds
	} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("D"))){
		gain_one_item(global.item_list.radish_seeds);		// gain radish seeds
	} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("R"))){
		gain_one_item(global.item_list.rose_seeds);		// gain rose seeds
	} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("A"))){
		gain_one_item(global.item_list.star_seeds);		// gain star seeds
	} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("M"))){
		gain_one_item(global.item_list.tomato_seeds);		// gain tomato seeds
	//} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("T"))){
	//	gain_one_item(global.item_list.tulip_seeds);		// gain tulip seeds
	//} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("N"))){
	//	gain_one_item(global.item_list.turnip_seeds);		// gain turnip seeds
	} else if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("H"))){
		gain_one_item(global.item_list.parts);		// gain turnip seeds
	}
	*/
		

	// death
	if (global.energy <= 0) {
		// die
		die();
	}
}