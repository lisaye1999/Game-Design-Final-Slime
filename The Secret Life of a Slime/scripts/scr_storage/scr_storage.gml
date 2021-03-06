// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function str_new_item(item, _count) constructor {
	name = item.name;
	icon = item.icon;
	menu_icon = item.menu_icon;
	max_count = item.max_count;
	count = _count;
	desc = item.desc;
	
}
// inventory manipulation
function str_get_item_count(item){
	inv = obj_storage_manager.inventory;
	count = 0;
	for(var i = 0; i < array_length(inv); i++ ){
		if(item.name == inv[i].name){
			count += inv[i].count;
		}
	}
	return count;
}

function str_will_item_fit(item, count){
	inv = obj_storage_manager.inventory;
	for(var i = 0; i < array_length(inv); i++ ){
		if(item.name == inv[i].name){
			if(inv[i].count == inv[i].max_count) {continue;}
			remaining = count - inv[i].count;
			return floor(remaining / item.max_count) < (obj_storage_manager.MAX_ITEM - array_length(inv));
		}
	}
	return floor(count / item.max_count) < (obj_storage_manager.MAX_ITEM - array_length(inv))
}


function str_gain_one_item(item){
	str_gain_item(item, 1);	
}

function str_lose_one_item(item){
	str_lose_item(item,1);
}

function str_gain_item(item, count){
	inv = obj_storage_manager.inventory;
	// check if we have item in inventory
	for(var i = 0; i < array_length(inv); i++ ){
		if(item.name == inv[i].name){
			// skip this stack if it is full
			if(inv[i].count == inv[i].max_count) {continue;}
			// add item
			newCount = inv[i].count + count;	
			if(newCount > inv[i].max_count){
				inv[i].count = inv[i].max_count;
				// new stack of the leftovers
				str_add_new_item_stack(item, newCount - inv[i].max_count);
				return;
			}
			else{
				inv[i].count = newCount;
				return;
			}
		}
	}
	// we don't have item
	str_add_new_item_stack(item, count);
}

function str_lose_item(item, count){
	inv = obj_storage_manager.inventory;
	remainingCount = count;
	to_delete = array_create(0);
	// check if we have item in inventory
	for(var i = array_length(inv) - 1; i >= 0; i--){
		if(item.name == inv[i].name){	
			// if we have enough
			if(remainingCount <= inv[i].count){
				inv[i].count -= remainingCount;
				remainingCount = 0;
				// remove from inventory if used up
				if(inv[i].count == 0){
					array_delete(inv, i, 1);
				}
				
			}
			// if we don't have enough
			else{
				remainingCount -= inv[i].count;
				array_push(to_delete, i);
			}
		}
	}
	if(remainingCount <= 0){
		// use up the stacks
		//show_debug_message(to_delete);
		for(var i = 0; i < array_length(to_delete); i++){
			array_delete(inv, to_delete[i], 1);
		}
	}
}

// starting with a new stack, add @count number of @items
// if inventory space is not enough, will discard the leftovers
function str_add_new_item_stack(item, count){
	inv = obj_storage_manager.inventory;
	remainingCount = count;
	while(remainingCount > 0 && array_length(inv) < obj_storage_manager.MAX_ITEM){
		itemCount = 0;
		if(remainingCount < item.max_count){
			itemCount = remainingCount;
		}
		else{
			itemCount = item.max_count;	
		}
		remainingCount -= itemCount;
		newItem = new new_item(item, itemCount);
		array_push(inv, newItem);
	}
	//show_debug_message(inv);
}

function move_from_inventory(item, count) {
	audio_play_sound(sfx_transfer_item, 0, false);
	lose_item(item, count);
	str_gain_item(item, count);
}

function move_from_storage(item, count) {
	audio_play_sound(sfx_transfer_item, 0, false);
	str_lose_item(item, count);
	gain_item(item, count);
}
