/// @description Insert description here
// You can write your code in this editor

old_ui_offset = 80;
textbox_x = 0;
textbox_y = (700 - textbox_height) - old_ui_offset;
accept_key = keyboard_check_pressed(ord("Z"));



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
			
		// setting individual characters and finding where the lines of text should break
		for(var c = 0; c < text_length[p]; c++){
			var _char_pos = c+1;
			// store individual character in the "char" array
			char[c,p] = string_char_at(text[p], _char_pos);
			
			// get current width of line
			var _txt_up_to_char = string_copy(text[p], 1, _char_pos);
			var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c,p]);
			
			// get the last free space 
			if(char[c,p] == " ") { last_free_space = _char_pos+1; }
			
			// get the line breaks 
			if(_current_txt_w - line_break_offset[p] > line_width){
				line_break_pos[ line_break_num[p], p] = last_free_space;
				line_break_num[p]++;
				var _txt_up_to_last_space = string_copy(text[p], 1, last_free_space);
				var _last_free_space_string = string_char_at(text[p], last_free_space);
				line_break_offset[p] = string_width(_txt_up_to_last_space) - string_width(_last_free_space_string);	
			}
		}
		// getting each character's coordinate
		for(var c = 0; c < text_length[p]; c++){
			var _char_pos = c+1;
			var _txt_x = textbox_x + text_x_offset[p] + text_border;
			var _txt_y = textbox_y + text_border;
			
			// get current width of line
			var _txt_up_to_char = string_copy(text[p], 1, _char_pos);
			var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c,p]);
			var _txt_line = 0;
			
			// compensate for string breaks
			for(var lb = 0; lb < line_break_num[p]; lb++){
				// if the current looping character is after a line break
				if (_char_pos >= line_break_pos[lb, p]) {
					var _str_copy = string_copy(text[p], line_break_pos[lb,p], _char_pos-line_break_pos[lb,p])
					_current_txt_w = string_width(_str_copy)
					
					// record the "line" this char should be on
					_txt_line = lb+1 // +1 since lb starts at 0
				}
			} // end of for loop
			
			// add to the x and y coordinates based on the new info
			char_x[c, p] = _txt_x + _current_txt_w;
			char_y[c,p] = _txt_y + _txt_line * line_margin;
		}// end of for loop
	}
	
}
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);

draw_set_font(ft_dialog)

// ** Typing the Text ** //
if(draw_char < text_length[page]){
	var _speaker_name = speaker_names[page];
	if(!is_speaker_sfx_playing && _speaker_name != "" && _speaker_name != "???"){
		switch(_speaker_name){
			case "Lavana":
				speaker_sfx = choose(sfx_talk_Lavana_1, sfx_talk_Lavana_2, sfx_talk_Lavana_3, sfx_talk_Lavana_4);
				audio_play_sound(speaker_sfx, 1, false);
				is_speaker_sfx_playing = true;
				break;
			case "Claude":
				speaker_sfx = choose(sfx_talk_Claude_1, sfx_talk_Claude_2, sfx_talk_Claude_3, sfx_talk_Claude_3);
				audio_play_sound(speaker_sfx, 1, false);
				is_speaker_sfx_playing = true;
				break;
			case "Nelu":
				speaker_sfx = choose(sfx_talk_Nelu_1, sfx_talk_Nelu_2, sfx_talk_Nelu_3, sfx_talk_Nelu_4);
				audio_play_sound(speaker_sfx, 1, false);
				is_speaker_sfx_playing = true;
				break;
			case "Lola":
				speaker_sfx = choose(sfx_talk_Lola_1, sfx_talk_Lola_2, sfx_talk_Lola_3, sfx_talk_Lola_4);
				audio_play_sound(speaker_sfx, 1, false);
				is_speaker_sfx_playing = true;
				break;	
			default:
				speaker_sfx = noone;
				break;
		}
		
	}
	
	draw_char += text_speed;
	// sets a min/max for draw_char
	draw_char = clamp(draw_char, 0, text_length[page]);
}

// flip through pages
if(accept_key){
	// if current page is done typing
	if(draw_char == text_length[page]){
		audio_play_sound(sfx_dialogue_non_npc, 1, false);
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
				create_textbox(option_link_id[option_pos]);
			}
			instance_destroy();	
		}
	}
	// if current page isn't filled yet
	else{ // display the whole page
		if(page > 0){
			draw_char = text_length[page];
			audio_stop_sound(speaker_sfx);
			is_speaker_sfx_playing = false;
		}
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
// name of speaker 
var _name = speaker_names[page]
if(_name != ""){
	// bg
	var speaker_name_width = string_width(_name);
	var speaker_name_bg_w = speaker_name_width + 20;
	var speaker_name_bg_h = 40;
	draw_sprite_ext(
		textbox_spr, 
		0, 
		_textbox_x + textbox_width - speaker_name_bg_w, 
		_textbox_y - speaker_name_bg_h, 
		speaker_name_bg_w/textbox_spr_w, 
		speaker_name_bg_h/textbox_spr_h, 
		0, 
		c_white, 
		1
	);
	// name
	draw_set_halign(fa_center);
	draw_set_color(c_aqua);
	var speaker_name_padding = 8;
	draw_text(
	_textbox_x + textbox_width - (speaker_name_bg_w / 2), 
	_textbox_y - speaker_name_bg_h + speaker_name_padding, 
	_name
	);
	draw_set_halign(fa_left);
	draw_set_color(c_white);
}


// ** Draw the Options ** //
if (draw_char == text_length[page] && page == page_number - 1){
	
	// option selection
	var key_down = keyboard_check_pressed(vk_down);
	var key_up = keyboard_check_pressed(vk_up);
	if((key_down || key_up) && option_num > 0) {audio_play_sound(sfx_move_cursor, 1, false);}
	option_pos += key_down - key_up;
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
/*
var _drawtext = string_copy(text[page], 1, draw_char);

draw_text_ext(
	textbox_x + text_x_offset[page] + text_border,
	textbox_y + text_border,
	_drawtext,
	line_margin,
	line_width
);
*/

for(var c = 0; c < draw_char; c++){
	// the text
	draw_text( char_x[c,page], char_y[c,page], char[c,page]);
}

