/// @description Insert description here
// You can write your code in this editor

audio_play_sound(bgm_home, 0, true)

// record how many days passed by
global.days = 0;
// record how much time passed by
global.time = 0;

// higher = depletes faster
ENERGY_DEPLETION_MULTIPLIER = 3.5;


// ** Game States ** 
is_room_transition = false;
// bushes

// ** Time Limit for Town ** //
// how much time you got in town
TOWN_TIME_LIMIT = 40; // seconds
// how much energy you lose if you're forced back
EXCEED_TIME_ENERGY_COST = 10;
// how much time to wait until you can go back to town
TRANSFORMATION_COOLDOWN_TIME = 30;
transformation_remaining = 0;
transformation_cooldown = 0;
// bool for if a warning pop up has occured for this visit
transformation_popup = false;
energy_popup = false;
// flag for warning going over time in village
should_warn_went_over_time_limit = false;

global.tiles_collision_name = "Tiles_Collision";
global.door_collision_name = "Door_Collision";
global.farm_collision_name = "Farmlock_Collision";
global.player_in_shop = false;
global.force_player_home = false;
global.food_shop_created = false;
global.general_shop_created = false;
// every time player goes to village, the shop restocks
global.should_food_shop_restock = false;
global.should_general_shop_restock = false;
global.has_been_to_town = false;
global.has_reached_ending = false;
global.is_forced_back = false;



global.tut_keys_on = true;
global.tutorial_active = true;
global.paused = false;
global.unpause_signal = false;

global.lola_door_unlock_day = 8;
global.extra_plot_unlock_day = 15;
global.advanced_machine_unlock_day = 18;
global.seedTier = 0;
global.addedSeeds1 = false;
global.addedSeeds2 = false;

objects_with_daily_events = ds_map_create();
objects_with_night_events = ds_map_create();
night_events_triggered = false;
