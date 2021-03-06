/// @description Insert description here
// You can write your code in this editor

old_ui_offset = 80;
textbox_x = 0;
textbox_y = (700 - textbox_height) - old_ui_offset;
accept_key = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"));

// ** Setup ** //
if(!setup){
	setup = true;
	
	page_number = array_length(text);
	
	// find how many char are on each page
	for(var p = 0; p < page_number; p++){
		text_length[p] = string_length(text[p]);
		
		// get the x position for the textbox
			// no character pic (center the textbox)
			text_x_offset[p] = (camera_get_view_width(view_camera[0]) - textbox_width) / 2;
	}
	
}
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);

draw_set_font(ft_dialog)

// ** Typing the Text ** //
if(draw_char < text_length[page]){
	draw_char += text_speed;
	// sets a min/max for draw_char
	draw_char = clamp(draw_char, 0, text_length[page]);
}

// flip through pages
if(accept_key){
	// if current page is done typing
	if(draw_char == text_length[page]){
		// next page
		if(page < page_number - 1){
			page++;
			draw_char = 0;
		}
		// no more pages left
		else{
			global.paused = is_previously_paused;
			// link text for options
			if(option_num > 0){
				//NEW FUNCTION NAME HERE
				create_confirmationbox(option_link_id[option_pos], curr_item, curr_machine);
			}
			instance_destroy();	
		}
	}
	// if current page isn't filled yet
	else{ // display the whole page
		draw_char = text_length[page];
	}
}

// ** Draw the Textbox ** //

var _textbox_x = textbox_x + text_x_offset[page];
var _textbox_y = textbox_y;

textbox_spr_w = sprite_get_width(textbox_spr);
textbox_spr_h = sprite_get_height(textbox_spr);
// textbox bg
draw_sprite_ext(
	textbox_spr, 
	0, 
	_textbox_x, 
	_textbox_y, 
	textbox_width/textbox_spr_w, 
	textbox_height/textbox_spr_h, 
	0, 
	c_white, 
	1
);

// ** Draw the Options ** //
if (draw_char == text_length[page] && page == page_number - 1){
	
	// option selection
	option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	option_pos = clamp(option_pos, 0, option_num - 1);

	// draw the options
	var _op_space = 30;
	var _op_bord = 8;
	var _op_margin = 15;
	for(var op = 0; op < option_num; op++){
		// the option box
		var _op_width = string_width(option[op]) + _op_bord * 2;
		draw_sprite_ext(
		textbox_spr, 
		0, 
		_textbox_x + _op_margin, 
		_textbox_y - (_op_space * option_num) + (_op_space * op), 
		_op_width/textbox_spr_w, 
		(_op_space - 1) / textbox_spr_h, 
		0, 
		c_white, 
		1);
		
		// draw arrow
		if(option_pos == op){
			draw_sprite(
			spr_option_arrow, 
			0,  
			_textbox_x,
			_textbox_y - (_op_space * option_num) + (_op_space * op) + 4)	
		}
		
		// the option text
		draw_text(
		_textbox_x + _op_bord + _op_margin,
		_textbox_y - _op_space * option_num + _op_space * op + 4,
		option[op]
		)
	}
	
}


// draw the text
var _drawtext = string_copy(text[page], 1, draw_char);

draw_text_ext(
	textbox_x + text_x_offset[page] + text_border,
	textbox_y + text_border,
	_drawtext,
	line_margin,
	line_width
);
