/// @description unlock at certain day
// You can write your code in this editor
// show_debug_message("daily check for farm plot triggered")


if (unlock_method == "day"){
	if (global.days >= unlock_requirement){
		if(room == home){
			if (global.paused){
				alarm[2] = 1;
			}
			else{
				create_textbox("auto-unlock-plot");	
				var _farm_plot_distance_x = (sprite_width-obj_farm_plot.sprite_width)/(x_plot_num-1);
				var _farm_plot_distance_y = (sprite_height-obj_farm_plot.sprite_height)/(y_plot_num-1);
				for (var _i = 0; _i < y_plot_num;++_i){
					var _farm_plot_y = y + _i * _farm_plot_distance_y;
					for (var _j = 0; _j < x_plot_num; ++_j){
						var _farm_plot_x = x + _j * _farm_plot_distance_x;
						instance_create_layer(_farm_plot_x,_farm_plot_y,"crops",obj_farm_plot);
					}
				}
			}
			ds_map_delete(obj_game_manager.objects_with_daily_events,id)			
			instance_destroy()
		}
	}
} 

if (unlock_method=="gold"){
	if (gold_and_days && global.days >= gold_and_days_daycount){
		if(room == home && !gold_and_days_text_displayed){
		ds_map_delete(obj_game_manager.objects_with_daily_events,id)	
		gold_and_days_text_displayed = true;
			if (global.paused){
				alarm[3] = 1;
			}else{
				if (should_i_talk){
					create_textbox("day-unlocked-money");
				}
			}
			prompt_text = "Unlock for 50G";
			//show_debug_message("gold and days: user event")
		}		
	}
}


