/// @description Insert description here
// You can write your code in this editor

instance_deactivate_object(id);

// a list of possible items this shop can sell

/// @param item
/// @param unit_price
/// @param max_stock
function create_shop_item(_item, _unit_price, _max_stock) constructor {
	item = _item;
	unit_price = _unit_price;
	max_stock = _max_stock;
}

inventory = 
{
	berries : new create_shop_item(global.item_list.berries, 4, 5),
	wheat : new create_shop_item(global.item_list.wheat, 8, 8),
	fish: new create_shop_item(global.item_list.fish, 15, 2),
	tomatoes: new create_shop_item(global.item_list.tomatoes, 10, 8),
	tomato: new create_shop_item(global.item_list.tomatoes, 10, 8), // for testing scrolling
}

// a list of items for sale now

curr_inventory = scr_restock_food_shop_inventory(inventory);

// ------- Menu 0 Dimensions -------- // 

option_num = array_length(curr_inventory);
NUM_ITEM_SHOWN_MAX = 4;
arrow_y_space = 40;
option_x_margin = 10;
option_y_margin = 4;
option_y_space = 24;

background_w = 250;
background_h = (NUM_ITEM_SHOWN_MAX * option_y_space) + (arrow_y_space * 2);

// ------- Menu 1 Dimensions -------- // 

background_item_details_w = 220;
background_item_details_h = 200;

item_info_magin_y = 40;
item_info_magin_x = 50;


shop_bg_spr = spr_shop_bg;


// ------- Menu variables -------- // 

// which item in the array we're on
option_pos = 0;
// which item to draw as first option in list (for when inventory > 4)
start_pos = 0;
// which item to draw as last option in list
end_pos = option_num > NUM_ITEM_SHOWN_MAX ? NUM_ITEM_SHOWN_MAX - 1 : option_num - 1 ;

// records which item was selected
selected_item = {}

// menu_level = 0 - on the list of items
// menu_level = 1 - on the item details
menu_level = 0;