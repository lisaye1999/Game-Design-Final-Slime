/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// helper func
// basically we only have code to use seeds here... if not a seed item doesnt get used
function use_item(item){
	switch(item.name){
		case global.item_list.wheat_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;
		case global.item_list.tomato_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_tomato_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;
		case global.item_list.carrot_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_carrot_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;
		case global.item_list.cauliflower_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_cauli_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;
		case global.item_list.cucumber_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_cucumber_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;	
		case global.item_list.eggplant_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_eggplant_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;			
		case global.item_list.lettuce_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_lettuce_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;	
		case global.item_list.pumpkin_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_pumpkin_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;		
		case global.item_list.radish_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_radish_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;	
		case global.item_list.rose_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_rose_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;		
		case global.item_list.star_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_star_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;	
		case global.item_list.tulip_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_tulip_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;			
		case global.item_list.turnip_seeds.name:
			with (instance_create_layer(relative_pos_x, relative_pos_y, "crops", obj_turnip_crop)){
				farm_plot = other.id;	
			}
			deactive_persistent_interactable(id)
			lose_one_item(item);
			audio_play_sound(sfx_use_item, 0, false);
			break;			
		default:
			create_textbox("warn-cannot-plant");
			return;
	}
}

if(!global.has_reached_ending){
	// if you have seeds AND no plant here currently
	inv = obj_inventory_manager.inventory
	inv_count = array_length(inv);
	
	// plant (attempt to use item if seed)
	switch (inv_slot){
		case 0:
			break;
		case 1:
			if (inv_count >= 1) use_item(inv[0]);
			break;
		case 2:
			if (inv_count >= 2) use_item(inv[1]);
			break;
		case 3:
			if (inv_count >= 3) use_item(inv[2]);
			break;
		case 4:
			if (inv_count >= 4) use_item(inv[3]);
			break;
		case 5:
			if (inv_count >= 5) use_item(inv[4]);
			break;
		case 6:
			if (inv_count >= 6) use_item(inv[5]);
			break;
		case 7:
			if (inv_count >= 7) use_item(inv[6]);
			break;
		case 8:
			if (inv_count >= 8) use_item(inv[7]);
			break;
		case 9:
			if (inv_count >= 9) use_item(inv[8]);
			break;
		case 10:
			if (inv_count >= 10) use_item(inv[9]);
			break;
	}
	// the rest is done by the crop itself
	}
else{
	create_textbox("ending_farming_lock");	
}

