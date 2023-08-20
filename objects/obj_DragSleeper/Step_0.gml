if(mouse_check_button_pressed(mb_left)) {
	if(dragIns == noone) {
		dragIns = collision_point(mouse_x, mouse_y, obj_Sleeper, false, false);
		with(dragIns) {
			if(isSleeping) {
				MyGetUp();
			}
			if(MyPathIsRunning()) {
				MyPathStop();
				isGoingToSleep = false;
			}
			MyEmote(irandom_range(0, array_length(gArrSkinEmoteSprs[skinId]) - 1));
			
			isDragging = true;
		}
		swayAng = random_range(-15, 15);
	}
} else if(mouse_check_button(mb_left)) {
	if(instance_exists(dragIns)) {
		dragIns.x = mouse_x;
		dragIns.y = mouse_y;
		
		if(swayAng > swayAngGrav) {
			swayAngSpeed -= swayAngGrav;
		} else if(swayAng < -swayAngGrav) {
			swayAngSpeed += swayAngGrav;
		}
		swayAngSpeed -= sign(swayAngSpeed) * swayAngFriction;
		swayAng += swayAngSpeed;
		
		swayAng += cos(degtorad(swayAng)) * (mouse_x - mouseXPrev) * -0.2;
		swayAng += sin(degtorad(swayAng)) * (mouse_y - mouseYPrev) * 0.2;
		
		dragIns.image_angle = swayAng;
		dragIns.x -= lengthdir_x(58, swayAng + 90);
		dragIns.y -= lengthdir_y(58, swayAng + 90);
	}
} else {
	if(dragIns != noone) {
		if(instance_exists(dragIns)) {
			dragIns.image_angle = 0;
			dragIns.isDragging = false;
			
			var _collBed = collision_point(mouse_x, mouse_y + 60, obj_Bed, false, false);
			if(_collBed != noone) {
				dragIns.MySleepOnBed(_collBed);
			}
		}
		swayAngSpeed = 0;
		swayAng = 0;
		dragIns = noone;
	}
}

mouseXPrev = mouse_x;
mouseYPrev = mouse_y;

//if(keyboard_check_pressed(vk_tab)) {
//	obj_Manager.MyCheckAndGenerateSleeper(317062050, "小麦盒子");
//}