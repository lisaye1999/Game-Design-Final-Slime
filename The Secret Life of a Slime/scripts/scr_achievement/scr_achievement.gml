// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// for recording gold spent for achievements
function achi_spent_gold(_amount_spent){
	achi_gain_progress("MODEST_SPENDER", _amount_spent);
	achi_gain_progress("BIG_SPENDER", _amount_spent);
	achi_gain_progress("THE_ECONOMY_IS_ON_MY_SHOULDER", _amount_spent);
}

// for recording crops harvested for achievements
function achi_harvest_crop(_amount_harvest){
	achi_gain_progress("FARMING_BEGINNER", _amount_harvest);
	achi_gain_progress("FARMING_INTERMEDIATE", _amount_harvest);
	achi_gain_progress("FARMING_MASTER", _amount_harvest);
}


function achi_gain_progress(_achi_name, _val){
	// check if achievement is already completed
	var _achievement = obj_achievement_manager.achievement_list[$ _achi_name];
	if(!_achievement.completed){
		new_progress = _achievement.progress + _val;
		goal = _achievement.goal;
		// if goes beyond or reach goal
		if(new_progress >= goal){
			// update progress and completed to true
			_achievement.progress = goal;
			_achievement.completed = true;
		}
		else{
			// update progress
			_achievement.progress = new_progress;
		}
	}
}