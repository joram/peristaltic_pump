fn = 100;
t = 0;

// https://www.pololu.com/picture/0J2543.600.jpg?1276230060
lock_d = 19.05 + t*2;
lock_r = lock_d/2;
lock_h = 5.08 + t;
lock_mount_hole_offset = 6.35;
lock_mount_hole_d = 2.845 + t*2;
lock_mount_hole_r = lock_mount_hole_d/2;
lock_mount_hole_l = 30;

// http://www.bearingworks.com/bearing_sizes/index.php
m8_d = 13 + t*2;
m8_r = m8_d/2;
m8_h = 5;
m8_axle_d = 4 + t*2;
m8_axle_r = m8_axle_d/2;
m8_axle_shield_r = m8_axle_r + 1;

module pump_arm_top(width, thickness){
  buffer = 0.1;
  radius = width/2;
  bearing_axle_l = m8_h+0.5+thickness*2;  
  difference(){
    pump_arm(width, thickness);
    union(){
      translate(v=[0,0, -25,]) cube(size=[30,100,50], center=true, $fn = fn);
  
      // connection bolts
      translate(v=[0,lock_r+3,0]) cylinder(r = 2.0+buffer, h = bearing_axle_l+buffer, center=true, $fn = fn);
      translate(v=[0,-lock_r-3,0]) cylinder(r =2.0+buffer, h = bearing_axle_l+buffer, center=true, $fn = fn);

      // bearing axles
      translate(v=[0, radius,0]) cylinder(r = m8_axle_r+buffer, h = bearing_axle_l+buffer, center=true, $fn = fn);
      translate(v=[0,-radius,0]) cylinder(r = m8_axle_r+buffer, h = bearing_axle_l+buffer, center=true, $fn = fn);
    }
  }
}

module pump_arm_bottom(width, thickness){
  radius = width/2;
  bearing_axle_l = m8_h+0.5+thickness*2;  
  union(){
    difference(){
      pump_arm(width, thickness);
      translate(v=[0,0, 25,]) cube(size=[30,100,50], center=true, $fn = fn);
    }
     // connection bolts
     translate(v=[0,lock_r+3,0]) cylinder(r = 2.0, h = bearing_axle_l, center=true, $fn = fn);
     translate(v=[0,-lock_r-3,0]) cylinder(r =2.0, h = bearing_axle_l, center=true, $fn = fn);

     // bearing axles
     translate(v=[0, radius,0]) cylinder(r = m8_axle_r, h = bearing_axle_l, center=true, $fn = fn);
     translate(v=[0,-radius,0]) cylinder(r = m8_axle_r, h = bearing_axle_l, center=true, $fn = fn);

  }
}

module pump_arm(width, thickness){  
  difference(){
    pump_arm_solid(width, thickness);
    pump_arm_negative(width, thickness);
  }
}

module pump_arm_solid(width, thickness){
  radius = width/2;
  bearing_axle_l = m8_h+0.5+thickness*2;  
  
  union(){
     //arm
     translate(v=[0,0,-m8_h/2-thickness/2-0.25]) cube(size=[m8_axle_shield_r*2,width, thickness], center=true, $fn = fn);
     translate(v=[0,0,m8_h/2+thickness/2+0.25]) cube(size=[m8_axle_shield_r*2,width, thickness], center=true, $fn = fn);

     // bearing axle shields
     translate(v=[0,-radius,-m8_h/2-thickness/2-0.25/2])  cylinder(r=m8_axle_shield_r, h = thickness+0.25, center=true, $fn = fn);
     translate(v=[0,radius,-m8_h/2-thickness/2-0.25/2])  cylinder(r=m8_axle_shield_r, h = thickness+0.25, center=true, $fn = fn);
     translate(v=[0,-radius,m8_h/2+thickness/2+0.25/2])  cylinder(r=m8_axle_shield_r, h = thickness+0.25, center=true, $fn = fn);
     translate(v=[0,radius,m8_h/2+thickness/2+0.25/2])  cylinder(r=m8_axle_shield_r, h = thickness+0.25, center=true, $fn = fn);

     // body
     cylinder(r=lock_r+2, h = bearing_axle_l, center=true, $fn = fn);
     cube(size=[m8_axle_shield_r*2, 32, bearing_axle_l], center=true, $fn = fn);

     // connection bolts
     translate(v=[0,lock_r+3,0]) cylinder(r = 2.0, h = bearing_axle_l, center=true, $fn = fn);
     translate(v=[0,-lock_r-3,0]) cylinder(r =2.0, h = bearing_axle_l, center=true, $fn = fn);

     // bearing axles
     translate(v=[0, radius,0]) cylinder(r = m8_axle_r, h = bearing_axle_l, center=true, $fn = fn);
     translate(v=[0,-radius,0]) cylinder(r = m8_axle_r, h = bearing_axle_l, center=true, $fn = fn);

     // bearings
     //translate(v=[0,-radius,0])  cylinder(r=m8_r, h =m8_h, center=true, $fn = fn);
     //translate(v=[0,radius, 0])  cylinder(r=m8_r, h = m8_h, center=true, $fn = fn);    
  }
}

module pump_arm_negative(width, thickness){
	// lock
	cylinder(r =lock_r, h = lock_h, center=true, $fn = fn);
       rotate([0,0,45]) union(){
	  translate(v=[0, lock_mount_hole_offset,0]) cylinder(r = lock_mount_hole_r, h = lock_mount_hole_l, center=true, $fn = fn);
	  translate(v=[0,-lock_mount_hole_offset,0]) cylinder(r = lock_mount_hole_r, h =lock_mount_hole_l, center=true, $fn = fn);
	  translate(v=[ lock_mount_hole_offset,0]) cylinder(r = lock_mount_hole_r, h = lock_mount_hole_l, center=true, $fn = fn);
         translate(v=[-lock_mount_hole_offset,0]) cylinder(r = lock_mount_hole_r, h = lock_mount_hole_l, center=true, $fn = fn);
      }
      // lock hole
      rotate([0,90,0]) translate(v=[0, 0, 10])  cylinder(r = 2.5, h = 20, center=true, $fn = fn);

      // 5mm stepper axle hole
     translate(v=[0,0,0]) cylinder(r = 2.6, h = thickness*4+11, center=true, $fn = fn);
}


//width = 68;
width = 60; 
thickness = 3;
translate(v=[0,0,20]) pump_arm_top(width, thickness);
//pump_arm_bottom(width, thickness);
