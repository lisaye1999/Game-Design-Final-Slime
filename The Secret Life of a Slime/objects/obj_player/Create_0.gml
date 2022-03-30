/// @description Insert description here
// You can write your code in this editor

move_spd = 2;
image_speed = 0.3;

slime_sprite[RIGHT] = spr_slime_right;
slime_sprite[UP] = spr_slime_up;
slime_sprite[LEFT] = spr_slime_left;
slime_sprite[DOWN] = spr_slime_down;

human_sprite[RIGHT] = spr_person_right;
human_sprite[UP] = spr_person_up;
human_sprite[LEFT] = spr_person_left;
human_sprite[DOWN] = spr_person_down;

sprite = slime_sprite
face = DOWN;

global.energy = 100;
global.energy_max=100;
global.gold = 10;
global.dead = false;

DIR = [[1,0],[0,-1],[-1,0],[0,1]]
interactable_object = noone;
last_interactable_object = noone;
draw_prompt_flag = false;
BOUNDARY_SPACE = 50; 

cam = view_camera[0];