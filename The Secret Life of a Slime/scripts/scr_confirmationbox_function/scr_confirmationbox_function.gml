// Script assets have changed for v2.3.0 see

/// @param text
function scr_add_conf_text(_text){
	 text[page_number] = _text;
	 
	 page_number++;
}

/// @param text_id
/// @param item
/// @param this_machine
function create_confirmationbox(_text_id, _item, _this_machine){

	with(instance_create_depth(0, 0, -9999, obj_confirmationbox)){
		curr_item = _item;
		curr_machine = _this_machine;
		scr_confirmation_text(_text_id, _item, _this_machine);	
	}	

}

/// @param option_text
/// @param link_id
function scr_confirmation_option(_option_text, _link_id){
	option[option_num] = _option_text;
	option_link_id[option_num] = _link_id;
	option_num++;
}
